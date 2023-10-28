#!/bin/bash

echo "Checking if SSH Folder Exists"

sshdir=/home/$USER
cd $sshdir
if [[ ! -d $sshdir/.ssh ]] 
  then
   echo "No ssh folder exists creating"
   mkdir $sshdir/.ssh
   echo "changing folder permissions to 0700" 
   sudo chmod 700 $sshdir/.ssh 

else 
    echo "ssh directory exists"
    echo "changing folder permissions to 0700" 
    sudo chmod 700 $sshdir/.ssh 
fi
printf "\n"
echo "This script will generate an ssh key pair"
echo "It is highly advised you do not add a password"
echo "Instead impliment the ssh key as passwordless"
echo "For added security add two factor authentication"
printf "\n"
echo "Enter an SSH Keyname:"
echo "When prompted for a passphrase press <enter>"
printf "\n"
read keyname
ssh-keygen -t ed25519 -f $keyname
mv $keyname $keyname.pub ~/.ssh
sudo chmod 600 ~/.ssh/$keyname
sudo chmod 644 ~/.ssh/$keyname.pub
