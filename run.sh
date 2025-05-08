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

echo "Choose the apps groups:"
select option in "basic apps" "utils packages" "terminal tools" "rice tools" "docs tools" "dev tools" "fonts" "flatpak apps" "exit"; do
    case $REPLY in
        1)
            echo "Installing basic apps"
            install_packages "${APPS[@]}"
            ;;
        2)
            echo "Installing utils packages"
            install_packages "${UTILS[@]}"
            ;;
        3)
            echo "Installing terminal tools"
            install_packages "${TERMINALTOOLS[@]}"
            ;;
        4)
            echo "Installing rice tools"
            install_packages "${RICETOOLS[@]}"
            ;;

        5)
            echo "Installing document tools"
            install_packages "${DOCS[@]}"
            ;;

        6)
            echo "Installing dev tools"
            install_packages "${CODE[@]}"
            ;;
        7)
            echo "Installing fonts"
            install_packages "${FONTS[@]}"
            ;;

        8)
            echo "Installing flatpaks apps"
            . install-flatpak.sh
            ;;

        9)
            echo "exiting"
            break
            ;;
    esac
done
