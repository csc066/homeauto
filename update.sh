#!/bin/bash

logger "Update Script: Starting..."

echo '[*] Refreshing repository cache...'
sudo apt-get update -y
echo '[*] Repository cache refreshed.'

echo '[*] Upgrading all existing packages...'
sudo apt-get upgrade -y
echo '[*] Existing packages upgraded.'

echo '[*] Upgrading Linux distribution (if available)...'
sudo apt-get dist-upgrade -y
echo '[*] Linux distribution upgrade processed.'

echo '[*] Clean up unused and cached packages...'
sudo apt-get autoclean -y
sudo apt-get autoremove -y
echo '[*] Package cleanup complete.'

if [ $(which raspi-config | wc -l) -gt 0 ]; then
        echo '[*] Raspberry Pi Detected.'
        echo '[*] Update the Raspberry Pi firmware to the latest (if available)...'
        sudo rpi-update
        echo '[*] Done updating firmware.'
fi

logger "Update Script: Done."

while true; do
        read -r -p "Do you wish to reboot? " choice
        case "$choice" in
                y|Y ) echo "[*] Rebooting..."; sudo reboot; break;;
                n|N ) echo "[*] Done."; break;;
                * ) echo "[-] Invalid response. Use 'y' or 'n'.";;
        esac
done