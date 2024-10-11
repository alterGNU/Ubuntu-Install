#!/bin/bash
# -[ FCT IS_INSTALLED ]-----------------------------------------------------------------------------
# check if a cmd is installed
is_installed(){ command -v "${1}" > /dev/null 2>&1 ; }

# -[ UPDATE ]---------------------------------------------------------------------------------------
cd ~
if is_installed "yes";then
    echo "coreutils already installed"
else
    yes | sudo apt install coreutils
fi
sudo apt update
yes | sudo apt upgrade

# -[ LISTE DES PAQUETS A INSTALLER ]----------------------------------------------------------------
PACK_LIST=("curl" "git" "zsh" "python3" "vim" "clang-12" "gdb" "valgrind" "make" "tree" "libbsd-dev" "php")
for pkg in ${PACK_LIST[@]};do
    echo -e "\t- Install package ${pkg}"
    if is_installed "${pkg}";then
        echo "Already installed"
    else
        yes | sudo apt install ${pkg}
    fi
done

# -[ CC ]-------------------------------------------------------------------------------------------
echo -e "\t- Config VIM"
if is_installed "cc";then
    echo "CC already configured"
else
    sudo update--alternatives --install /usr/bin/cc cc /usr/bin/clang-12 100
fi

# -[ VIM ]------------------------------------------------------------------------------------------
echo -e "\t- Config VIM"
if [[ -d ~/.vim ]];then
    echo "Vim already configured"
else
    cd && git clone https://github.com/alterGNU42/.vim.git ~/.vim #TODO Replace by install.sh
fi

# -[ GOOGLE-CHROME ]--------------------------------------------------------------------------------
echo -e "\t- Install Google-Chrome"
if is_installed "google-chrome";then
    echo "Already installed"
else
    cd ~/Downloads
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 
    sudo dpkg -i google-chrome-stable_current_amd64.deb 
    sudo apt install -f
    cd ~
fi

# -[ GIT ]------------------------------------------------------------------------------------------
echo -e "\t- Config GIT"
if [[ -f ~/.gitconfig ]];then
    echo "Git Already Configured"
else
    git config --global user.name "alterGNU42"
    git config --global user.email "alterGNU.42@gmail.com"
    git config --global core.editor "vim"
    git config --global mergetool vimdiff
    git config --global diff.tool vimdiff
    git config --global difftool.prompt false
    git config --global alias.dt difftool
fi
# -[ NORMINETTE ]-----------------------------------------------------------------------------------
echo -e "\t- Config Norminette"
if is_installed "norminette";then
    echo "Git Already Configured"
else
    yes | sudo apt install python3-setuptools
    yes | sudo apt install pipx
    pipx install norminette
    pipx ensurepath
fi

# -[ OH-MY-ZSH ]------------------------------------------------------------------------------------
echo -e "\t- Config ZSH"
if [[ -f ~/.zshrc ]];then
    echo "ZSH Already configured"
else
    sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
    chsh -s $(which zsh)
    echo "alias ccw=\"cc -Wall -Wextra -Werror -lbsd\"" >> ~/.zshrc
    echo "export PATH=/home/altergnu/.local/funcheck/host:$PATH" >> ~/.zshrc
fi

