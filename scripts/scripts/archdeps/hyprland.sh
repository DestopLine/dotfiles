#!/usr/bin/env bash
if ! command -v yay &> /dev/null; then
	echo "You need yay to install these dependencies"
	exit 1
fi

yay -S --needed git hyprland hyprpaper hyprlock hyprpolkitagent xdg-desktop-portal-hyprland waybar\
	ttf-jetbrains-mono-nerd kitty rofi-wayland rofi-calc grimblast-git swappy copyq dmenu wl-clipboard\
	network-manager-applet noto-fonts noto-fonts-emoji noto-fonts-cjk numix-cursor-theme adwaita-dark\
	lxappearance alsa-utils pipewire pipewire-pulse wireplumber python pavucontrol blueman polkit\
	qt5ct udiskie

echo "Done!"
echo "Once in a graphical session, you should run 'lxappearance' to set the themes and cursors"
