#!/bin/bash
echo "Updating the System"
sudo apt update -y; sudo apt upgrade -y
sudo apt purge libreoffice* -y
sudo apt autoremove libreoffice -y

echo "Installing Required Packages"
sudo apt install vim -y
sudo apt install unattended-upgrades -y
sudo apt install git -y
sudo apt install trash-cli -y
sudo apt install htop -y
sudo apt install menulibre -y
sudo apt install curl -y
sudo apt install wget -y
sudo apt install timeshift -y
sudo apt install bleachbit -y
sudo apt install variety -y

echo "Installing Calibre Ebook Reader"
sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin

echo "Installing Flatpak"
sudo apt install flatpak -y 
sudo apt install gnome-software-plugin-flatpak -y
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

echo "Installing VLC and Multimedia Codecs"
sud apt install libavcodec-extra -y
sudo apt install vlc -y

echo "Purging Unwanted Packages"
sudo apt purge firefox-esr -y
sudo apt purge nano -y

echo "Installing Chromium"
sudo apt install chromium -y

echo "Adding Debian Backports"
sudo touch /etc/apt/sources.list.d/backports.list
echo "deb http://deb.debian.org/debian/ bookworm-backports contrib main non-free non-free-firmware" |sudo tee /etc/apt/sources.list.d/backports.list
sudo apt update

echo "Install Latest Debian Kernel From Backports"
#sudo apt -t bookworm-backports install linux-image-amd64 -y

echo "Installing Steam"
# Install steam-devices
sudo apt install steam-devices
# Add in the required device files from github
git clone https://github.com/ValveSoftware/steam-devices
cd ~/steam-devices
sudo cp *.rules /etc/udev/rules.d
cd /etc/udev/rules.d
sudo chown user:user 60-steam-input.rules
sudo chown user:user 60-steam-vr.rules

# Install Steam Flatpak
flatpak install flathub com.valvesoftware.Steam
flatpak install flathub com.github.tchx84.Flatseal

# Install Additional Flatpak Apps
flatpak install flathub io.github.martinrotter.rssguardlite -y
flatpak install flathub org.gnome.meld -y
flatpak install flathub io.github.giantpinkrobots.flatsweep -y
flatpak install flathub org.kde.krdc -y
flatpak install flathub app.ytmdesktop.ytmdesktop -y
flatpak install flathub com.skype.Client -y
flatpak install flathub com.obsproject.Studio -y
flatpak install flathub org.gnome.DejaDup -y
flatpak install flathub org.libreoffice.LibreOffice -y
flatpak install flathub io.github.dvlv.boxbuddyrs -y
# flatpak run net.mkiol.SpeechNote

echo "Cloning Personal Git Hub Repos"
#git clone https://github.com/wevansprojects/MinimalSystemSetup.git
git clone https://github.com/wevansprojects/ShellSetup.git

echo "Change Steams access permissions in Flatseal"
echo "Connect controller to bluetooth"
echo "Launch Steam change settings so that all games use proton"
echo "Launch Steam in Big Picture Mode and test the controller"
echo "Launch a game in steam big picture mode and test the controller"
echo "Exit steam completely"

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
