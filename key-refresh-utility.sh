# ===========================================
#  🔐 Arch Key Refresh & Cleanup Utility
#  Author: blackfly13
#  Purpose: Fix, refresh & clean GPG keyring
#  Works on: Arch Linux, EndeavourOS
# ===========================================


#!/bin/bash

set -e

# Function to show a loading spinner
spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    while ps -p $pid > /dev/null; do
        for s in $spinstr; do
            echo -ne "\r$s   "
            sleep $delay
        done
    done
    echo -ne "\rDone!     \n"
}

echo "==> Step 1: Updating archlinux-keyring..."
sudo pacman -Sy --noconfirm archlinux-keyring

read -p "Do you want to RESET the GPG keyring (only if broken)? [y/N] " reset
if [[ "$reset" =~ ^[Yy]$ ]]; then
    echo "==> Removing old keyring..."
    sudo rm -rf /etc/pacman.d/gnupg
    echo "==> Initializing new keyring..."
    sudo pacman-key --init
fi

echo "==> Step 2: Populating Arch Linux keys..."
sudo pacman-key --populate archlinux

# Add EndeavourOS keys
echo "==> Populating EndeavourOS keys..."
sudo pacman-key --populate endeavouros

# Add other keyring providers here if needed
# sudo pacman-key --populate chaotic

# Display loading spinner for refresh keys
echo "==> Step 3: Refreshing keys from keyservers..."
(
    sudo pacman-key --refresh-keys
) &
spinner $!

echo "==> Step 4: Pruning expired or revoked keys..."

# Get all key fingerprints
all_keys=$(pacman-key --list-keys | grep '^pub' | awk '{print $2}' | cut -d'/' -f2)

for key in $all_keys; do
    key_info=$(gpg --with-colons --list-keys "$key" 2>/dev/null | grep '^pub')

    # If gpg fails to retrieve key info, skip
    if [[ -z "$key_info" ]]; then
        echo "Error: Unable to retrieve information for key $key."
        continue
    fi

    expiry_date=$(echo "$key_info" | cut -d: -f7)
    flags=$(echo "$key_info" | cut -d: -f12)

    # Check if key is revoked or expired
    is_revoked=$(echo "$flags" | grep -q 'r' && echo "yes" || echo "no")
    is_expired="no"

    if [[ "$expiry_date" != "" && "$expiry_date" != "0" ]]; then
        expiry_seconds=$(date -d "$expiry_date" +%s 2>/dev/null || echo 0)
        now_seconds=$(date +%s)
        if (( expiry_seconds < now_seconds )); then
            is_expired="yes"
        fi
    fi

    if [[ "$is_revoked" == "yes" || "$is_expired" == "yes" ]]; then
        echo " -> Removing key: $key (revoked: $is_revoked, expired: $is_expired)"
        sudo pacman-key --delete "$key"
    fi
done

# Refresh the keys after deletion
echo "==> Refreshing keys after deletion..."
(
    sudo pacman-key --refresh-keys
) &
spinner $!

read -p "Do you want to manually review remaining keys? [y/N] " review
if [[ "$review" =~ ^[Yy]$ ]]; then
    pacman-key --list-keys | less
    echo "Use 'sudo pacman-key --delete <keyid>' to remove any unwanted keys."
fi

echo "==> Keyring cleanup complete!"
