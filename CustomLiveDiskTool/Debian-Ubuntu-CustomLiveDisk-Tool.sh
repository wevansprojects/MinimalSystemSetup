#!/bin/bash
#!/bin/bash
#https://www.linux-live.org/#explore
#https://helpdeskgeek.com/linux-tips/make-a-custom-live-linux-distro-with-linux-live-kit/
echo " ----------------------------------"
echo "|Debian and Ubuntu Custom Live Disk|"
echo " ----------------------------------"
echo " " 
echo "Installing required packages"
echo "----------------------------"
echo " "
sudo apt install git
sudo apt install squashfs-tools-ng
sudo apt install squashfs-tools
sudo apt install genisoimage
sudo apt install zip
echo " "
echo "-----------------------------"
echo "Running Custom Live Disk Tool"
cd /tmp
git clone https://github.com/Tomas-M/linux-live.git
cd linux-live/
sudo ./build
cd /tmp
./gen_linux_zip.sh
#./gen_linux_iso.sh
