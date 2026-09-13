#!/usr/bin/bash

if [ -f /etc/os-release ]; then
    . /etc/os-release
    
    if [[ "$ID" =~ (debian|ubuntu) ]] || [[ "$ID_LIKE" =~ (debian|ubuntu) ]]; then
        echo "Debian(-based) detected"
        sudo apt update
        sudo apt install -y curl gnupg ca-certificates
        curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
        sudo apt install -y nodejs neovim git

    elif [[ "$ID" =~ (arch|manjaro) ]] || [[ "$ID_LIKE" =~ (arch) ]]; then
        echo "Arch(-based) detected"
        sudo pacman -S --needed --noconfirm git neovim nodejs yarn
    else
        echo "Unknown distribution. Exited with code 2"
        exit 2
    fi
elif [ -f $PREFIX/etc ]; then
    ehco "Termux detected"
    pkg install -y nodejs neovim git
else
    echo "Can not detect distrubution. Exited with code 3";
    exit 3
fi

if [ -d ~/.config/nvim/ ]; then
    echo "Found existing Nvim configuration, rename it to nvim-bak"
    rm -rf ~/.config/nvim-bak/
    mv ~/.config/nvim/ ~/.config/nvim-bak/
fi

git clone https://github.com/whilnew/MyConfigNeovim.git ~/.config/nvim

nvim

echo "Scripts finished successfully with exit code 0."

exit 0
