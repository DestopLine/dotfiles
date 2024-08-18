#!/usr/bin/env bash
if ! command -v yay &> /dev/null; then
	echo "You need yay to install these dependencies"
	exit 1
fi

yay -S --needed git xclip ttf-jetbrains-mono-nerd kitty zsh starship fd ripgrep eza bat fzf zoxide python nvm
source /usr/share/nvm/init-nvm.sh
nvm install --lts
npm i -g @angular/cli
