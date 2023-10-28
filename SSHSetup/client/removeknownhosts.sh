#!/bin/bash
echo "Sometimes you will need to remove a known host "
echo "Especially if you have a duplicate entry in the known_hosts file"
cd ~/.ssh/
printf "\n"
echo "Type in the alias or ip you want to remove:"
read remhost
ssh-keygen -R $remhost
