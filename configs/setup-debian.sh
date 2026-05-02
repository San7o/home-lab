#!/bin/bash

#
# Debian setup
# ============
#
# Call this program as a regular user after setting up the network and
# installing sudo.
#
# Note that debian has some important binaries in /usr/sbin such as
# dhcpd which are not present in the non-root path.
# 

CORE="git curl gcc clang"
BROWSER=firefox-esr
EDITOR="emacs neovim"
WM="sway kitty dmenu"
UTILS="gh brightnessctl xwayland network-manager pipewire pipewire-pulse pipewire-alsa wireplumber"

set -e

if [ "$USER" == "root" ]; then
	echo "You should not call this script as root"
	exit 1
fi

sudo usermod -aG sudo $USER
sudo apt --fix-broken install $CORE $UTILS $WM $EDITOR $BROWSER

# Copy config files

mkdir -p /home/$USER/.config
cp -r * /home/$USER/.config

# Install vimplug
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Done"
