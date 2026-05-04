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

CORE="git curl gcc clang rustc"
BROWSER=firefox-esr
EDITOR="emacs neovim"
WM="sway kitty dmenu i3status"
UTILS="gh brightnessctl xwayland network-manager pipewire pipewire-pulse pipewire-alsa wireplumber alsa-utils pavucontrol xdg-utils"

set -e

if [ "$USER" == "root" ]; then
	echo "You should not call this script as root"
	exit 1
fi

sudo usermod -aG sudo $USER
sudo apt update
sudo apt --fix-broken install
sudo apt install $CORE $UTILS $WM $EDITOR $BROWSER

sudo systemctl enable NetworkManager

# Copy config files

mkdir -p /home/$USER/.config
cp -r * /home/$USER/.config

# Install vimplug
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Enable pipewire
systemctl --user enable --now pipewire pipewire-pulse wireplumber

echo "Done"

# You should also add the following sources in /ets/apt/sources.list
#
#   deb http://deb.debian.org/debian/ trixie main
#   deb-src http://deb.debian.org/debian/ trixie main
#
#   deb https://security.debian.org/debian-security trixie-security main
#   deb-src https://security.debian.org/debian-security trixie-security main
#
#   deb https://deb.debian.org/debian trixie-updates main
#   deb-src https://deb.debian.org/debian trixie-updates main
#
