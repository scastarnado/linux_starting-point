#!/bin/bash

packageManager="apt"

# Lets setup the OS, i dont care about the rest... for now
DisplayHeader(
clear # Clear the screen and print the header
echo "                                                                                                                                 "
echo "               ██████╗██╗      █████╗  ██████╗██╗  ██╗██╗████████╗██╗   ██╗██████╗  █████╗  ██████╗██╗  ██╗██╗████████╗██╗   ██╗ "
echo "              ██╔════╝██║     ██╔══██╗██╔════╝██║ ██╔╝██║╚══██╔══╝╚██╗ ██╔╝██╔══██╗██╔══██╗██╔════╝██║ ██╔╝██║╚══██╔══╝╚██╗ ██╔╝ "
echo "              ██║     ██║     ███████║██║     █████╔╝ ██║   ██║    ╚████╔╝ ██████╔╝███████║██║     █████╔╝ ██║   ██║    ╚████╔╝  "
echo "              ██║     ██║     ██╔══██║██║     ██╔═██╗ ██║   ██║     ╚██╔╝  ██╔═══╝ ██╔══██║██║     ██╔═██╗ ██║   ██║     ╚██╔╝   "
echo "              ╚██████╗███████╗██║  ██║╚██████╗██║  ██╗██║   ██║      ██║   ██║     ██║  ██║╚██████╗██║  ██╗██║   ██║      ██║    "
echo "               ╚═════╝╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝   ╚═╝      ╚═╝   ╚═╝     ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝   ╚═╝      ╚═╝    "
echo "                                                                                                                                 "
echo "                                                                                                                                 "
echo "                                                                                                                                 "
echo "                                                                                                                                 "
)

InstallVSCode() {
    echo "Installing VSCode..."
    wget -q0- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -h root -m 644 packages.microsoft.gpg /usr/share/keyrings
    sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/respos/vscode stable main" > /etc/apt/soruces.list.d/vscode.list'
    sudo $packageManager update
    sudo $packageManager install -y code
}

InstallSublimeText() {
    echo "Installing Sublime Text..."
    sudo $packageManager install -y sublime-text
}

InstallAtom() {
    echo "Installing Atom..."
    sudo $packageManager install -y atom
}

InstallGeany() {
    echo "Installing Geany..."
    sudo $packageManager install -y geany
}

InstallGedit() {
    echo "Installing Gedit..."
    sudo $packageManager install -y gedit
}

InstallNano() {
    echo "Installing Nano..."
    sudo $packageManager install -y nano
}

InstallVim() {
    echo "Installing Vim..."
    sudo $packageManager install -y vim
}


DisplayHeader

# Update and upgrade
echo "Updating and Upgrading..."
sudo $packageManager update && sudo $packageManager upgrade

DisplayHeader

# Select OS
items=(1 "Red Hat"
       2 "Debian"
       3 "Arch"
       4 "Ubnutu"
)

while choice=$(dialog --title "OS Selection menu" \
                --menu "Please select the Linux distro yours is based on" 10 40 5 "${items[@]}" \
                2>&1 >/dev/tty)
    
    case $choice in
        1) packageManager="yum" ;;
        2) packageManager="dpkg" ;;
        3) packageManager="pacman" ;;
        4) packageManager="apt" ;;
        *) # some action on other
    esac
done
clear # clear after user pressed Cancel

DisplayHeader

# First of all, install git
echo "Installing git..."
sudo apt install -y git
read -p "Enter yout Git user name: " git_username
read -p "Enter your Git email: " git_email

git config --gloal user.name "$git_username"
git config --global user.email "$git_email"

git config --global init.defaultBranch main
git config --global pull.rebase false

DisplayHeader

# Install IDEs
items=(1 "Visual Studio Code"
       2 "Sublime Text"
       3 "Atom"
       4 "Geany"
       5 "Gedit"
       6 "Nano"
       7 "Vim"
)

while choice=$(dialog --title "IDE Selection menu" \
                --checklist "Please select the IDE(s) you want to install up to three" 10 40 5 "${items[@]}" \
                2>&1 >/dev/tty)
    
    case $choice in
        1) InstallVSCode ;;
        2) InstallSublimeText ;;
        3) InstallAtom ;;
        4) InstallGeany ;;
        5) InstallGedit ;;
        6) InstallNano ;;
        7) InstallVim ;;
        *) # some action on other
    esac
done
clear # clear after user pressed Cancel

DisplayHeader

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
