Let me know if you'd like any additional modifications!

# Linux Development Environment Setup Scripts

This repository contains shell scripts for setting up development environments on freshly installed Linux distributions. Currently, it includes a script for Ubuntu-based systems, with more setups planned for other distros in the future.

## Available Setup Scripts

### Ubuntu-based Linux Setup

---

This script automates the installation of essential development tools and utilities on Ubuntu-based systems. It includes tools like Git, GCC, VSCode, Neovim, and more.

### Features
- **System Update**: Automatically updates and upgrades the system.
- **Git Setup**: Installs Git and prompts for user name and email for Git configuration.
- **Development Tools**: Installs compilers (GCC), build tools, and text editors (VSCode, Neovim, Geany, Gedit).
- **Debugging Tools**: Installs YASM (assembler) and KDbg (debugger).
- **System Cleanup**: Cleans up unnecessary packages after the setup.

### How to Use

1. Follow this commands:
   ```bash
   git clone https://github.com/scastarnado/linux_starting-point.git
   cd linux_starting_point
   chmod +x preferred_script.sh
   ./preferred_script.sh
