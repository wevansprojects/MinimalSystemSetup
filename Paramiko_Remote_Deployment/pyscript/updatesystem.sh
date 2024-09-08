#!/bin/bash

# Check System type Base
distro=$(grep "ID_LIKE" /etc/os-release|cut -d= -f2|sed 's/"//g')

# Use DNF For RedHat based systems
if [[ $distro == *"rhel"* ]]; then
  echo "This is a Redhat Based System Using DNF to Install Packages"

  # Upgrade System
  dnf upgrade -y
  crontab -r
#  sleep 3
#  sudo -S reboot


else
# Use APT For Debian based systems
  echo "This is a Debian Based System Using APT to Install Packages"

  # Upgrade System
  apt update -y
  apt upgrade -y  
  crontab -r
#  sleep 3
#  sudo -S reboot
fi

echo "------------------------------------------------------------"
