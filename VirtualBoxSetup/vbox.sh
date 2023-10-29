#!/bin/bash
sudo apt update;sudo apt upgrade
sudo apt install build-essential dkms linux-headers-$(uname -r)
sudo su
cd /media/cdrom0
sh VboxLinuxAdditions.run
