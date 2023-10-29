#!/bin/bash
cd ~/.ssh
echo "Chose a private ssh key from the list below"
ls -la ~/.ssh |grep -v .pub|grep -v known
read -p ": " certname
read -p "Choose a Port Number: " pnumber
read -p "Type in the remote users username: " usr
read -p "Type in server IP Address: " ip
echo "Run the command below this will add the new ssh key to the remote server: "
echo "ssh-copy-id -f -i ~/.ssh/$certname -p $pnumber $usr@$ip"

echo "IMPORTANT: The Correct Way To Authenticate Is To Use This Command "
ssh -i .ssh/$certname -p $pnumber $user@$ip
