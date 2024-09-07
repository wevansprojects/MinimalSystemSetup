#!/bin/bash
# Packages To Unistall
packages=("neofetch" "vim")
#packages=("neofetch")

# Check System type Base
distro=$(grep "ID_LIKE" /etc/os-release|cut -d= -f2|sed 's/"//g')

# Use DNF For RedHat based systems
if [[ $distro == *"rhel"* ]]; then
  echo "This is a Redhat Based System Using DNF to Install Packages"

  # Uninstall Packages
  for pkg in "${packages[@]}"; do
  dnf erase "$pkg" -y
  done

else
# Use APT For Debian based systems
  echo "This is a Debian Based System Using APT to Install Packages"

  # Uninstall Packages
  for pkg in "${packages[@]}"; do
  apt purge "$pkg" -y
  done

fi
