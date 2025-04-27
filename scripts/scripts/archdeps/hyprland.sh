#!/usr/bin/env bash
if ! command -v yay &> /dev/null; then
	echo "You need yay to install these dependencies"
	exit 1
fi

yay -S --needed git hyprland hyprpaper hyprlock hyprpolkit waybar ttf-jetbrains-mono-nerd kitty rofi rofi-calc\
	grim slurp swappy copyq dmenu wl-clipboard network-manager-applet noto-fonts noto-fonts-emoji noto-fonts-cjk\
	numix-cursor-theme adwaita-dark lxappearance alsa-utils pipewire pulseaudio python pavucontrol blueman polkit qt5ct\
	udiskie

echo "Done!"
echo "Once in a graphical session, you should run 'lxappearance' to set the themes and cursors"
