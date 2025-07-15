# Arch-key-refresh-utility

# 🔐 Arch Linux GPG Keyring Cleanup and Repair Script

A powerful and interactive Bash script to **repair**, **refresh**, and **clean up** your Arch Linux GPG keyring. Ideal for resolving issues like failed package verification, revoked or expired keys, and broken GPG trust.

---

## 📦 Features

- ✅ Automatically updates the `archlinux-keyring` package
- 🛠️ Optional reset of the entire GPG keyring (for broken installations)
- 🔑 Repopulates keys for:
  - Arch Linux
  - EndeavourOS
  - *(Add support for others like Chaotic-AUR easily)*
- 🔄 Refreshes keys from keyservers
- 🧹 Automatically detects and **removes revoked or expired** keys
- 👀 Optional manual review of all installed keys

---

## ⚙️ Requirements

- OS: Arch Linux or Arch-based distros (like EndeavourOS, Manjaro)
- Shell: Bash
- Utilities:
  - `pacman`
  - `gpg`
  - `awk`, `grep`, `cut`, `less`
  - `sudo`
  - `date` with GNU date support (default on most distros)

---

## 🚀 Usage


### 📁 1. Clone the Repository

```bash
git clone https://github.com/blackfly13/Arch-key-refresh-utility.git
cd Arch-key-refresh-utility
```

### 🔓 2. Make the Script Executable
  ``bash
    chmod +x keyring-cleanup.sh
    ```
### ▶️ 3. Run the Script
  ```bash
  ./keyring-cleanup.sh
  ```
    
### 🧑‍💻 During execution, you’ll be prompted:

    Whether to reset the GPG keyring (only if it's broken)

    Whether to review remaining keys after cleanup


## 🧩 Extend Support

This script currently populates keys for:

- ✅ Arch Linux
- ✅ EndeavourOS

If you're using additional repositories or third-party sources like **Chaotic-AUR**, you can easily extend the script by **uncommenting** or **adding** the relevant keyring provider.

### 🔧 To Enable Chaotic-AUR Support

1. Open the script:
   ```bash
   nano keyring-cleanup.sh
   ```
2. Find the section:
  ```bash
  # sudo pacman-key --populate chaotic
  ```
3. Uncomment it:
  ```bash
    sudo pacman-key --populate chaotic
  ```
4. Save and exit the script.

  This will import keys from Chaotic-AUR, assuming you've already added the Chaotic-AUR repository to your system.

➕ Add More Providers

  You can add additional key providers in the same way:
  ```bash
  sudo pacman-key --populate <provider-name>
  ```
  Just replace <provider-name> with the name of the repo you want to support.
  
  💡 Example: 
  ```bash 
      sudo pacman-key --populate manjaro (only if using Manjaro-specific mirrors)
  ```

⚠️ Warnings

    ⚠️ Resetting deletes all key trust data. Do this only if you're facing persistent GPG issues.

    🧹 Always verify key removals — some expired keys may still be needed if updated on the server.

    🔐 You must run this script with sudo for most operations.
