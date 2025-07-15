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
- 🔄 Refreshes keys from keyservers (with a spinner animation)
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

### 1. Download the script

```bash
curl -O https://raw.githubusercontent.com/yourusername/yourrepo/main/keyring-cleanup.sh
chmod +x keyring-cleanup.sh
