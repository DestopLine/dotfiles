#!/usr/bin/env bash
if ! command -v yay &> /dev/null; then
	echo "You need yay to install these dependencies"
	exit 1
fi

yay -S --needed pacman-contrib informant
sudo systemctl enable paccache.timer
echo "Add your user to the informant group with 'sudo usermod -aG informant <username>'"
