#!/bin/bash

# -[ UPDATE ]---------------------------------------------------------------------------------------
cd ~
sudo apt install coreutils
sudo apt update
yes | sudo apt upgrade

# -[ LISTE DES PAQUETS A INSTALLER ]----------------------------------------------------------------
PACK_LIST=("git" "zsh" "vim")
for pkg in ${PACK_LIST[@]};do
    echo -e "\t- Install package ${pkg}"
    yes | sudo apt install ${pkg}
done

# -[ VIM ]------------------------------------------------------------------------------------------
echo -e "\t- Config VIM"
git clone https://github.com/alterGNU42/.vim.git && cd ~/.vim && git submodule init && git submodule update

# -[ OH-MY-ZSH ]------------------------------------------------------------------------------------
echo -e "\t- Install Oh-My-Zsh"
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
chmod -s $(which zsh)

# -[ GOOGLE-CHROME ]--------------------------------------------------------------------------------
echo -e "\t- Install Google-Chrome"
cd ~/Downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 
sudo dpkg -i google-chrome-stable_current_amd64.deb 
sudo apt install -f
cd ~

# -[ NORMINETTE ]-----------------------------------------------------------------------------------
# -[ CLANG ]----------------------------------------------------------------------------------------
# -[ GCC ]------------------------------------------------------------------------------------------
