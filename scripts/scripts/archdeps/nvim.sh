#!/usr/bin/env bash
if ! command -v yay &> /dev/null; then
	echo "You need yay to install these dependencies"
	exit 1
fi

yay -S --needed git neovim fd ripgrep xclip ttf-jetbrains-mono-nerd kitty unzip luarocks imagemagick nvm
source /usr/share/nvm/init-nvm.sh
nvm install --lts
