#!/usr/bin/bash

if [ -d ~/.config/nvim/ ]; then
    echo "Found existing Nvim configuration, rename it to nvim-bak"
    rm -rf ~/.config/nvim-bak/
    mv ~/.config/nvim/ ~/.config/nvim-bak/
fi

if [ -f /etc/os-release ]; then
    . /etc/os-release
    
    # Kiểm tra biến ID hoặc ID_LIKE chứa debian / arch
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
else
    echo "Can not detect distrubution. Exited with code 3";
    exit 3
fi

git clone https://github.com/whilnew/MyConfigNeovim.git ~/.config/nvim

nvim

exit 0
