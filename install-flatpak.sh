#!/bin/bash

FLATPAKS=(
    com.discordapp.Discord
    rest.insomnia.insomnia
    com.github.tchx84.Flatseal
    org.localsend.localsend_app
    com.valvesoftware.Steam
    io.github.flattool.Warehouse
    org.gnome.baobab
    io.gitlab.librewolf-community
    org.vinegarhq.Sober
)

for pak in "${FLATPAKS[@]}"; do
    if ! flatpak list | grep -i "$pak" &> /dev/null; then
        echo "Installing flatpak: $pak"
        flatpak install --nointeractive "$pak"
    else
        echo "flatpak already installed: $pak"
    fi
done
