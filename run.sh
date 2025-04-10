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





clear
printLogo

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

source install.sh



echo "Installing flatpak"
. install-flatpak.sh


