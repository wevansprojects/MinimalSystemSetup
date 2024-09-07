#!/bin/bash

project="wevansprojects"
repo="MinimalSystemSetup"

# Create deployment script from github repo
git clone git@github.com:${project}/${repo}.git

# Check if github is installed
gityn=$(whereis git|awk '{print $2}')
if [[ -z "$gityn" ]]; then
echo "git is not installed"
   exit 1
else
echo "git is installed" 
cd /tmp
git clone git@github.com:${project}/${repo}.git
cd ${repo}
fi

# Check System type Base
if [[ $distro == *"rhel"* ]]; then
echo "This is a Redhat Based System Using DNF to Install Packages"

  # Install on Redhat based systems
cd RedHatSetup
else

# Install on Debian based systems
echo "This is a Debian Based System Using APT to Install Packages"
cd DebianSetup/DesktopSetup
sudo chmod u+x *.sh
./DesktopSetup.sh
rm -rf /tmp/${repo}
fi
