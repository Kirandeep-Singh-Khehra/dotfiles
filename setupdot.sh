#!/bin/bash

dotfiles_dir="$(realpath "$(dirname "$0")")"
install_path="${1:-"$HOME"}"

echo "[+] Installing dotfiles"
rsync -av --progress "$dotfiles_dir/" "$install_path/"

ln -sf ~/.my_aliases ~/.bash_aliases

echo "[+] Setting up ranger"
sudo apt install -y \
    fd-find \
    gum \
    ;

# Ranger setup
if ! [[ -d ~/.config/ranger/plugins/ranger_devicons ]]; then
    git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
fi

