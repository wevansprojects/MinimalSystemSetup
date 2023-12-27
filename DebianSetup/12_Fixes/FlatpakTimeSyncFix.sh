#!/bin/bash
echo "Resolving a very annoying timesync error with Flatpak"
sudo apt install systemd-timesyncd -y; sudo systemctl enable systemd-timesyncd; sudo systemctl start systemd-timesyncd; 

echo "Please edit the following file /etc/systemd/timesyncd.conf"
echo "Look for the following lines"
printf "\n"

echo "[Time]"
echo "#NTP="
echo "#FallbackNTP=0.debian.pool.ntp.org 1.debian.pool.ntp.org 2.debian.pool.ntp.org 3.debian.pool.ntp.org"

echo "Change the above lines so they look like this"
echo "NTP=time.google.com"
echo "FallbackNTP=0.debian.pool.ntp.org 1.debian.pool.ntp.org 2.debian.pool.ntp.org 3.debian.pool.ntp.org"
echo "Save the file. Now run sudo systemctl restart systemd-timesyncd"
sudo systemctl status systemd-timesyncd
