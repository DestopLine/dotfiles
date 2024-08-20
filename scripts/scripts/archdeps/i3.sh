#!/usr/bin/env bash
if ! command -v yay &> /dev/null; then
	echo "You need yay to install these dependencies"
	exit 1
fi

yay -S --needed git xorg i3 i3blocks xkb-switch-i3 xclip ttf-jetbrains-mono-nerd kitty rofi rofi-calc xss-lock nitrogen flameshot copyq dmenu picom network-manager-applet noto-fonts noto-fonts-emoji noto-fonts-cjk numix-cursor-theme adwaita-dark lxappearance alsa-utils pipewire pulseaudio yad xdotool
echo "Done!"
echo "Once in a graphical session, you should run 'lxappearance' to set the themes and cursors"
