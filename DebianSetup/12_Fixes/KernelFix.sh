#!/bin/bash
sudo rm /etc/kernel/postinst.d/z50-raspi-firmware
sudo rm /etc/kernel/postrm.d/z50-raspi-firmware
sudo rm /etc/initramfs/post-update.d/z50-raspi-firmware
sudo apt purge raspi-firmware

sudo apt-get autoclean
sudo apt-get clean
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade
sudo apt-get -f install
