#!/usr/bin/env bash
sudo systemctl enable fstrim.timer
pacman -S --needed intel-ucode libva-intel-driver vulkan-intel lib32-vulkan-intel pipewire alsa-utils bluez bluez-utils
sudo systemctl enable --now bluetooth.service
