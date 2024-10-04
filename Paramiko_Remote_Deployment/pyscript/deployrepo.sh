#!/bin/bash

distro=$(cat /etc/os-release)

project="wevansprojects"
repo="MinimalSystemSetup"

# Check System type Base
if [[ $distro == *"rhel"* ]]; then
echo "This is a Redhat Based System Using DNF to Install Packages"
dnf install git
cd /tmp
git clone https://github.com/${project}/${repo}.git
cd ${repo}
cd RedHatSetup/HTTPSServer/SetupScripts
sudo chmod u+x *.sh
./1_Prerequisites.sh
./3_nginxhttpstestsite.sh
rm -rf /tmp/${repo}
else

# Install on Debian based systems
echo "This is a Debian Based System Using APT to Install Packages"
apt install git
cd /tmp
git clone https://github.com/${project}/${repo}.git
cd ${repo}
cd DebianSetup/HTTPSServer/SetupScripts
sudo chmod u+x *.sh
./1_Prerequisites.sh
./3_nginxhttpstestsite.sh
rm -rf /tmp/${repo}
fi

