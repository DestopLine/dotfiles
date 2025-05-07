#!/usr/bin/env bash

sudo systemctl enable fstrim.timer
sudo timedatectl set-ntp true
sudo pacman -S --needed amd-ucode bluez bluez-utils nvidia-utils lib32-nvidia-utils mesa vulkan-radeon lib32-vulkan-radeon\
	brightnessctl pipewire pipewire-pulse wireplumber auto-cpu-freq
sudo systemctl enable --now bluetooth.service auto-cpu-freq

# Use pipewire instead of pulseaudio.
# Pulseaudio is buggy on this laptop.
sudo systemctl --user enable --now pipewire pipewire-pulse wireplumber

# Enable Bluetooth and WiFi coexistence, this allows Bluetooth and
# WiFi to be enabled at the same time.
echo "options iwlwifi bt_coex_active=1" | sudo tee /etc/modprobe.d/iwlwifi.conf
sudo mobprobe -r iwlwifi && sudo modprobe iwlwifi
