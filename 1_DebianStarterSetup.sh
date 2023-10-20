#!/bin/bash
echo "Updating the System"
sudo apt update -y; sudo apt upgrade -y

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
sudo sed 's/ENABLED=\"false\"/ENABLED=\"true\"/' sysstat
cd /etc/cron.d
echo "# Run system activity accountin tool every 10 minutes" >> sysstat
echo " "
echo "*/10 * * * * root /usr/lib64/sa/sa1 1 1" >> sysstat
echo " "
echo "# Generate a daily summary of process accounting at 23:55" >> sysstat
echo "55 23 * * * root /usr/lib64/sa/sa2 -A" >> sysstat

echo "Applying System Service Startups"
sudo systemctl enable unattended-upgrades
sudo systemctl start unattended-upgrades
sudo systemctl enable sysstat
sudo systemctl start sysstat

echo "Purging Unwanted Packages"
sudo apt purge firefox-esr* -y
sudo apt purge nano -y
