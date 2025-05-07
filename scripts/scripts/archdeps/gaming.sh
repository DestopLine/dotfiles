#!/usr/bin/env bash

if ! command -v yay &> /dev/null; then
	echo "You need yay to install these dependencies"
	exit 1
fi

yay -S --needed wine wine-gecko wine-mono heroic-games-launcher-bin steam fuse
