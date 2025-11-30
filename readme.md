# 🌐 Rubinho Env

> Complete development environment configurations for **Linux** and **macOS**

This repository contains **all my development environment configurations**, including:

- 📝 Configuration files (dotfiles)
- 🎨 Themes and fonts
- ⚙️ Automated installation scripts
- 🔧 Cursor/VS Code configurations
- 🛠️ Auxiliary tools

---

## 🚀 Quick Start

### 1. Clone the repository

```bash
git clone https://github.com/rubensdeoliveira/rubinho-env.git
cd rubinho-env
```

### 2. Choose your platform

- [🐧 Linux](#-linux-installation)
- [🍎 macOS](#-macos-installation)

---

## 🐧 Linux Installation

### Automatic Installation (Recommended)

```bash
cd linux/scripts

# Run all scripts automatically (single command)
bash 00-install-all.sh
```

**Note:** The script will automatically handle environment loading. After completion, simply close and reopen your terminal to ensure all configurations are applied.

### Manual Installation

```bash
cd linux/scripts

# Run in order:
bash 01-configure-git.sh
bash 02-install-zsh.sh          # ⚠️ Close terminal after this
bash 03-install-zinit.sh
bash 04-install-starship.sh
bash 05-install-node-nvm.sh
bash 06-install-yarn.sh
bash 07-install-tools.sh
bash 08-install-font-jetbrains.sh
bash 09-install-cursor.sh
bash 10-configure-keyboard.sh
bash 11-configure-terminal.sh
bash 12-configure-ssh.sh
bash 14-configure-inotify.sh
bash 15-install-cursor-extensions.sh
bash 16-configure-cursor.sh
bash 17-install-docker.sh       # ⚠️ Logout/login after this (final step)
```

---

## 🍎 macOS Installation

### Automatic Installation (Recommended)

```bash
cd macos/scripts

# Run all scripts automatically (single command)
bash 00-install-all.sh
```

**Note:** The script will automatically handle environment loading. After completion, simply close and reopen your terminal to ensure all configurations are applied.

### Manual Installation

```bash
cd macos/scripts

# Run in order:
bash 01-configure-git.sh
bash 02-install-zsh.sh          # ⚠️ Close terminal after this
bash 03-install-zinit.sh
bash 04-install-starship.sh
bash 05-install-node-nvm.sh
bash 06-install-yarn.sh
bash 07-install-tools.sh
bash 08-install-font-jetbrains.sh
bash 10-configure-ssh.sh
bash 11-configure-file-watchers.sh
bash 12-install-cursor-extensions.sh
bash 13-configure-cursor.sh
bash 14-install-docker.sh
bash 15-configure-terminal.sh
bash 11-configure-file-watchers.sh
bash 12-install-cursor-extensions.sh
bash 13-configure-cursor.sh
```

---

## 📋 Complete Script Listing

### **00-install-all.sh** (Master Script)
Runs all installation scripts in sequence automatically.
- Executes scripts 01-17 (Linux) or 01-15 (macOS) in the correct order
- Automatically loads NVM and environment configurations during installation
- Handles all setup phases: Initial Setup, Environment Configuration, Development Tools, and Application Setup
- **Note:** After completion, close and reopen your terminal to ensure all configurations are applied

---

## Individual Scripts

### **01-configure-git.sh**
Configures Git with identity and preferences.
- Configures name and email
- Sets default branch to `main`
- Enables colors in Git

**Note:** Git must already be installed (required to clone the repository).

---

### **02-install-zsh.sh**
Installs and configures Zsh as the default shell.
- Installs Zsh, Curl and Git
- Sets Zsh as the default shell
- Creates minimal `.zshrc`
- Adds auxiliary configurations

**⚠️ After running:** Close and reopen the terminal.

---

### **03-install-zinit.sh**
Installs Zinit (fast Zsh plugin manager).
- Clones the Zinit repository
- Sets up plugin management system

---

### **04-install-starship.sh**
Installs and configures the Starship prompt.
- Installs Starship
- Copies and configures `starship.toml`
- Updates `.zshrc` with Zinit + Starship + tools

**Note:** The NVM configuration is automatically added to `.zshrc` and will be available after restart

---

### **05-install-docker.sh**
Installs Docker and Docker Compose.
- Removes old Docker installations
- Adds official Docker repository
- Installs Docker Engine, Docker Compose and plugins
- Adds user to docker group

**⚠️ After running:** Logout/login to use Docker without sudo.

---

### **06-install-node-nvm.sh**
Installs NVM (Node Version Manager) and Node.js.
- Installs NVM
- Installs Node.js version 22
- Sets Node 22 as default

---

### **07-install-yarn.sh**
Installs Yarn via Corepack.
- Enables Corepack
- Installs and activates Yarn 1

---

### **08-install-font-jetbrains.sh**
Installs JetBrains Mono Nerd Font.
- Downloads the font from the official repository
- Installs in user fonts directory
- Updates font cache

---

### **09-install-cursor.sh** (Linux only)
Installs Cursor Editor on Linux.
- Downloads Cursor .deb package
- Installs via dpkg
- Verifies installation

### **09-configure-terminal.sh** (macOS only)
Configures iTerm2 with Dracula theme.
- Clones Dracula theme repository
- Provides instructions for manual configuration
- Sets font to JetBrainsMono Nerd Font 16pt
- Applies Dracula color preset

---

### **10-configure-keyboard.sh** (Linux only)
Configures keyboard for US International on Linux.
- Sets US International layout
- Enables cedilla (ç) support
- Configures keyboard options

---

### **11-configure-terminal.sh** (Linux only)
Configures GNOME Terminal with Dracula theme.
- Installs dconf-cli
- Creates "rubinho" profile in GNOME Terminal
- Applies Dracula theme
- Configures JetBrains Mono Nerd Font
- Removes old profiles

---

### **12-configure-ssh.sh**
Configures SSH for Git.
- Installs Git and OpenSSH
- Generates ed25519 SSH key
- Configures SSH agent
- Sets correct permissions
- Copies public key to clipboard

**👉 After running:** Add the SSH key to GitHub/GitLab.

---

### **11-configure-file-watchers.sh** (macOS only)
Configures file watcher limits for macOS.
- Adjusts system limits for file watching
- Applies changes

### **13-configure-inotify.sh** (Linux only)
Configures inotify limits for file watching.
- Increases `max_user_watches` to 524288
- Makes the configuration persistent
- Applies changes

---

### **14-install-cursor-extensions.sh**
Installs essential Cursor extensions.
- Color Highlight
- DotENV
- ESLint
- GitLens
- Markdown Preview Enhanced
- Prisma
- px to rem
- Reload
- Tailwind CSS IntelliSense
- Indent Rainbow
- Symbols (icons)
- Catppuccin (theme)

---

### **15-configure-cursor.sh**
Applies Cursor configurations.
- Copies `settings.json` to Cursor
- Copies `keybindings.json` to Cursor
- Configures theme and preferences

**👉 After running:** Open Cursor again to apply everything.

---

## 📁 Repository Structure

```
rubinho-env/
├── linux/
│   ├── config/              # Configuration files
│   │   ├── starship.toml   # Starship prompt configuration
│   │   ├── user-settings.json  # Cursor settings
│   │   ├── cursor-keyboard.json  # Cursor keyboard shortcuts
│   │   └── zsh-config      # Additional Zsh configurations
│   └── scripts/             # Installation scripts (01-15)
├── macos/
│   ├── config/              # Same configurations as Linux
│   └── scripts/             # Scripts adapted for macOS
└── readme.md               # This file
```

---

## 🛠 Maintenance

To modify scripts, update tools or version environment adjustments, just edit the corresponding files and push the changes.

---

## 📝 Important Notes

### Prerequisites
- **Git** must be installed to clone the repository
- **macOS:** Homebrew will be installed automatically if it doesn't exist

### Required Restarts
1. **After script 02:** Close and reopen the terminal
2. **After script 05 (Linux):** Logout/login to use Docker without sudo
3. **After script 05 (macOS):** Make sure Docker Desktop is running

### Dependencies
- Scripts must be run in numerical order (01 → 02 → 03 → ...)
- Some scripts depend on others (e.g., Yarn needs Node installed)

### Custom Configurations
- Edit files in `linux/config/` or `macos/config/` before running the scripts
