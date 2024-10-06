#!/bin/bash

# Update and upgrade
echo "Updating and Upgrading..."
sudo apt update && sudo apt upgrade

# Install git
echo "Installing git..."
sudo apt install -y git
read -p "Enter yout Git user name: " git_username
read -p "Enter your Git email: " git_email

git config --gloal user.name "$git-username"
git config --global user.email "$git_email"

git config --global init.defaultBranch main
git config --global pull.rebase false

# Install gcc and c stuff
echo "Installing GCC and C stuff..."
sudo apt install -y gcc g++ make libc6-dev build-essential

# Install VSCode
echo "Installing VSCode..."
wget -q0- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -h root -m 644 packages.microsoft.gpg /usr/share/keyrings
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/respos/vscode stable main" > /etc/apt/soruces.list.d/vscode.list'
sudo apt update
sudo apt install -y code

# Install nvim
echo "Installing NVIM (btw)..."
sudo apt install -y neovim

# Setup nvim environment
git clone https://github.com/nvim-lua/kickstart.nvim.git ~/.config/nvim
nvim --headless "+Lazy! sync" +qa # Install nvum plugins in headless mode

# Install geany
echo "Installing geany..."
sudo apt install -y geany

# Install YASM (assembler)
echo "Installing YASM..."
sudo apt install -y yasm

# Install KDbg (debugger)
echo "Installing KDbg..."
cmake -DCMAKE_INSTALL_PREFIX=/usr .
git clone -b maint https://github.com/j6t/kdbg.git
cmake .
make
sudo make install

# Install gedit
echo "Installing GEDIT..."
sudo apt install -y gedit

# Clean up whatever
echo "Cleaning..."
sudo apt autoremove -y
sudo apt autoclean

# Doine
echo "Development evnironemnt setup is complete :)"
