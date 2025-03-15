#!/usr/bin/env bash
sudo systemctl enable fstrim.timer
sudo timedatectl set-ntp true
pacman -S --needed intel-ucode libva-intel-driver vulkan-intel lib32-vulkan-intel pipewire alsa-utils bluez bluez-utils
sudo systemctl enable --now bluetooth.service
