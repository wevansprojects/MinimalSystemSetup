#!/bin/bash
sudo apt update;sudo apt upgrade
sudo apt install build-essential dkms linux-headers-$(uname -r)
cd /media/cdrom0
sudo sh ./VboxLinuxAdditions.run
