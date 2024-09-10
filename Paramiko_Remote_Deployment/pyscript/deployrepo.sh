#!/bin/bash

project="wevansprojects"
repo="MinimalSystemSetup"

# Check if github is installed
gityn=$(whereis git|awk '{print $2}')
if [[ -z "$gityn" ]]; then
echo "git is not installed"
   exit 1
else
echo "git is installed" 
cd /tmp
git clone https://github.com/${project}/${repo}.git
cd ${repo}
fi

# Check System type Base
if [[ $distro == *"rhel"* ]]; then
echo "This is a Redhat Based System Using DNF to Install Packages"

  # Install on Redhat based systems
echo "Nothing To Do Here!!!"
else

# Install on Debian based systems
echo "This is a Debian Based System Using APT to Install Packages"
cd /tmp/${repo}/DebianSetup/HTTPSServer/SetupScripts
sudo chmod u+x *.sh
./1_Prerequisites.sh
#./2_bashrchelper.sh
./3_nginxhttpstestsite.sh
rm -rf /tmp/${repo}
fi
