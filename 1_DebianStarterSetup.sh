#!/bin/bash
echo "Updating the System"
sudo apt update -y; sudo apt upgrade -y

echo "Installing Required Packages"
sudo apt install vim -y
sudo apt install unattended-upgrades -y
sudo apt install git -y
sudo apt install trash-cli -y
sudo apt install lynx -y

echo "Applying System Service Startups"
sudo systemctl enable unattended-upgrades
sudo systemctl start unattended-upgrades

echo "Purging Unwanted Packages"
sudo apt purge firefox-esr* -y
sudo apt purge nano -y
