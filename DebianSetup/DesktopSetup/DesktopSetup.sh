#!/bin/bash
echo "Updating the System"
sudo rm /etc/kernel/postinst.d/z50-raspi-firmware
sudo rm /etc/kernel/postrm.d/z50-raspi-firmware
sudo rm /etc/initramfs/post-update.d/z50-raspi-firmware
sudo apt purge raspi-firmware -y

#sudo apt-get autoclean
#sudo apt-get clean
#sudo apt-get update
#sudo apt-get upgrade
#sudo apt-get dist-upgrade
#sudo apt-get -f install

sudo apt update -y; sudo apt upgrade -y

sudo apt purge libreoffice* -y
sudo apt autoremove libreoffice -y

echo "Installing Required Packages"
sudo apt install vim -y
sudo apt install unattended-upgrades -y
sudo apt install git -y
sudo apt install trash-cli -y
sudo apt install htop -y
sudo apt install sysstat -y
sudo apt install lynx -y

echo "Setting Up SystStat Monitoring"
cd /etc/default
sudo sed -i 's/ENABLED=\"false\"/ENABLED=\"true\"/' sysstat

echo "Applying System Service Startups"
sudo systemctl enable unattended-upgrades
sudo systemctl start unattended-upgrades
sudo systemctl enable sysstat
sudo systemctl start sysstat

echo "Installing Flatpak"
sudo apt install flatpak -y 
sudo apt install gnome-software-plugin-flatpak -y
#sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

echo "Installing VLC and Multimedia Codecs"
sud apt install libavcodec-extra -y
sudo apt install vlc -y

echo "Purging Unwanted Packages"
sudo apt purge firefox-esr -y
sudo apt purge nano -y

echo "Installing Chromium"
sudo apt install chromium

echo "Adding Debian Backports"
#sudo touch /etc/apt/sources.list.d/backports.list
#echo "deb http://debian.org/debian bookworm-backports main" |sudo tee /etc/apt/sources.list.d/backports.list
#sudo apt update

echo "Setting Up Personal Bashrc"
cd $HOME
echo "#Nginx Test and Reload Alias Commands" >> .bashrc
echo "alias nt='sudo nginx -t'" >> .bashrc
echo "alias nr='sudo systemctl reload nginx.service' " >> .bashrc
echo " " >> .bashrc
echo "#PHP Service Reload Alias" >> .bashrc
echo "alias phpr='sudo systemctl reload php8.2-fpm.service'" >> .bashrc
echo " " >> .bashrc
echo "#Trash CLI Alias (prevention of rm usage)" >> .bashrc
echo "alias tp='sudo trash-put'" >> .bashrc
echo "alias tl='sudo trash-list'" >> .bashrc
echo "alias tr='sudo trash-restore'" >> .bashrc
echo "alias te='sudo trash-empty'" >> .bashrc
echo "alias rm='echo "try using trash-cli commands instead! example: trash-put"'" >> .bashrc
echo 'export HISTTIMEFORMAT="%d/%m/%y %T "' >> ~/.bashrc
clear
echo "For accessing new .deb software packages from the backports repo"
echo "Type: sudo apt install -t bookworm-backports package-name"
echo "SCRIPT COMPLETE Please CLOSE THE TERMINAL WINDOW!!!"
