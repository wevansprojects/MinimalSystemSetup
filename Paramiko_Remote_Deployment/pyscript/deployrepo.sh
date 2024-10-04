#!/bin/bash

distro=$(cat /etc/os-release)

project="wevansprojects"
repo="MinimalSystemSetup"

# Check System type Base
if [[ $distro == *"rhel"* ]]; then
echo "This is a Redhat Based System Using DNF to Install Packages"
dnf install git

  # Install on Redhat based systems
cd /tmp
git clone https://github.com/${project}/${repo}.git
cd ${repo}
cd /tmp/${repo}/RedHatSetup/HTTPSServer/
sudo chmod u+x *.sh
./RedhatHTTPSSiteSetup.sh
else

# Install on Debian based systems
echo "This is a Debian Based System Using APT to Install Packages"
apt install git
cd /tmp
git clone https://github.com/${project}/${repo}.git
cd ${repo}
cd /tmp/${repo}/DebianSetup/HTTPSServer/SetupScripts
sudo chmod u+x *.sh
./1_Prerequisites.sh
#./2_bashrchelper.sh
./3_nginxhttpstestsite.sh
#3_nginxhttpstestsite_mod.sh
rm -rf /tmp/${repo}
fi

