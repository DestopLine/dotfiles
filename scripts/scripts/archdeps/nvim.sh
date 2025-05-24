#!/usr/bin/env bash
if ! command -v yay &> /dev/null; then
	echo "You need yay to install these dependencies"
	exit 1
fi

yay -S --needed git neovim fd ripgrep xclip ttf-jetbrains-mono-nerd unzip imagemagick nvm wget tree-sitter-cli jq dotnet-sdk\
	tectonic ghostscript
source /usr/share/nvm/init-nvm.sh
nvm install --lts
dotnet tool install -g dotnet-outdated-tool
dotnet tool install -g dotnet-script
