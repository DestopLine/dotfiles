#!/usr/bin/env bash
sudo systemctl enable fstrim.timer
pacman -S --needed intel-ucode libva-intel-driver pipewire alsa-utils
