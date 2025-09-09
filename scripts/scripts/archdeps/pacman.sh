#!/usr/bin/env bash
if ! command -v yay &> /dev/null; then
	echo "You need yay to install these dependencies"
	exit 1
fi

yay -S --needed pacman-contrib informant reflector
sudo systemctl enable paccache.timer
sudo systemctl enable reflector.timer

sudo tee /etc/xdg/reflector/reflector.conf << EOF
--save /etc/pacman.d/mirrorlist
--protocol https
--latest 5
--sort rate
EOF

echo "Add your user to the informant group with 'sudo usermod -aG informant <username>'"
