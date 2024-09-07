#!/bin/bash
# Packages To Install
packages=("neofetch" "vim" "tldr")
#packages=("vim")

# Check System type Base
distro=$(grep "ID_LIKE" /etc/os-release|cut -d= -f2|sed 's/"//g')

# Use DNF For RedHat based systems
if [[ $distro == *"rhel"* ]]; then
  echo "This is a Redhat Based System Using DNF to Install Packages"

  # Install Packages
  for pkg in "${packages[@]}"; do
  dnf install "$pkg" -y
  done

else
# Use APT For Debian based systems
  echo "This is a Debian Based System Using APT to Install Packages"

  # Install Packages
  for pkg in "${packages[@]}"; do
  apt install "$pkg" -y
  done

fi
