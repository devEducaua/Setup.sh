#!/bin/bash

printLogo() {
    cat << "EOF"

    ____   __  __             __  __      _         ____  __          
   /  _/  / / / /_______     / / / /___  (_)  __   / __ )/ /__      __
   / /   / / / / ___/ _ \   / / / / __ \/ / |/_/  / __  / __/ | /| / /
 _/ /   / /_/ (__  )  __/  / /_/ / / / / />  <   / /_/ / /_ | |/ |/ / 
/___/   \____/____/\___/   \____/_/ /_/_/_/|_|  /_____/\__/ |__/|__/  

EOF
}

# Begin of Script #

clear
printLogo

set -e 

source install.sh

if [ ! -f "packages.conf" ]; then
  echo "Error: packages.conf not found!"
  exit 1
fi

source packages.conf

sudo pacman -Syu --noconfirm

if ! command -v yay &> /dev/null; then
  echo "Installing yay AUR helper..."
  sudo pacman -S --needed git base-devel --noconfirm
  git clone https://aur.archlinux.org/yay.git
  cd yay
  echo "building yay"
  makepkg -si --noconfirm
  cd ..
  rm -rf yay
else
  echo "yay is already installed"
fi

echo "Installing basic utilities"
install_packages "${UTILITIES[@]}"

echo "Installing file utilities"
install_packages "${FILES[@]}"

echo "Installing document tools"
install_packages "${DOCS[@]}"

echo "Installing rice tools"
install_packages "${RICE[@]}"

echo "Installing dev tools"
install_packages "${CODE[@]}"

echo "Installing fonts"
install_packages "${FONTS[@]}"

echo "Installing flatpaks apps"
. install-flatpak.sh
