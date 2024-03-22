#!/bin/bash

function checker(){
nmtuichecker=$(whereis nmcli|cut -d ":" -f2|cut -d" " -f2)

if [[ -f "$nmtuichecker"  ]]
then      
   echo "nmcli already installed!!!" 2&> /dev/null
else 
     echo "nmcli is NOT installed!!!"
     echo "please install nmcli for this tool to work"
     echo "For Red Hat Base Systems Install with:" 
     echo "sudo dnf install NetworkManager-tui -y"
     echo "For Debian Base Systems Install with:" 
     echo "sudo apt install nmtui -y"
     exit 0
fi
}
checker
function osdetails()
{
clear      
result=$(hostnamectl);
whiptail --title "Host Information " --msgbox "$result" 0 0 3>&1 1>&2 2>&3
SystemMenu
}

function networkdetails()
{
clear      
result=$(echo "IP Address:" $(hostname -I |cut -d " " -f1);echo "Default Gateway:" `ip route|grep default|cut -d" " -f3`;
 echo "External IP Address:" $(wget -qO- https://ipecho.net/plain | xargs echo));
whiptail --title "Network Details " --msgbox "$result" 0 0 3>&1 1>&2 2>&3
NetworkManageMenu
}

function wificheck {
      result=$(nmcli dev status)      
whiptail --title "Wifi Network Check " --msgbox "$result" 0 0 3>&1 1>&2 2>&3
WifiNetworkManagerMenu
}
function enablewifi {
      result=$(nmcli radio wifi on)      
whiptail --title "Wifi Enabled" --msgbox "$result" 0 0 3>&1 1>&2 2>&3
WifiNetworkManagerMenu
}
function disablewifi {
      result=$(nmcli radio wifi off)      
whiptail --title "Wifi Disabled" --msgbox "$result" 0 0 3>&1 1>&2 2>&3
WifiNetworkManagerMenu
}

function availablewifi {
      result=$(nmcli dev wifi list)
whiptail --title "Available Wifi Connections " --msgbox "$result" 0 0 3>&1 1>&2 2>&3
      WifiNetworkManagerMenu
}

function wificonnect {
    clear  
    nmcli dev wifi list  
    printf "\n"
    read -rp "Enter You're Wifi SSID Name: " ssid
    sudo nmcli --ask dev wifi connect "$ssid"
    WifiNetworkManagerMenu
}

function ConfigureNetwork()
{
nmtui
SystemMenu
}

function NetworkManageMenu(){
 MNU=$(whiptail --title ":Network Management Menu:" --menu "Select options" 15 60 8 \
"1" "Network Details" \
"2" "Manage Wifi Connection"   \
"3" "Configure Network"   \
"4" "Back To SystemMenu"   3>&1 1>&2 2>&3)

case $MNU in
     1)networkdetails;;
     2)WifiNetworkManagerMenu;;
     3)ConfigureNetwork;;
     4)SystemMenu;; 
esac
}

function WifiNetworkManagerMenu() {
 MNU=$(whiptail --title ":Manage Wifi Network Menu:" --menu "Select options" 15 60 8 \
"1" "Check Active Wifi Connection" \
"2" "Enable Wifi" \
"3" "Disable Wifi" \
"4" "Connect to Wifi"   \
"5" "Back To Main Menu"   3>&1 1>&2 2>&3)

case $MNU in
     1)wificheck;;
     2)enablewifi;;
     3)disablewifi;;
     4)wificonnect;;
     5)SystemMenu;; 
esac
}

function SystemMenu() {
 MNU=$(whiptail --title ":Configure Wifi Network Menu:" --menu "Select options" 15 60 8 \
"1" "Host Information" \
"2" "Network Connection Management" \
"3" "Exit" 3>&1 1>&2 2>&3)

case $MNU in
     1)osdetails;;
     2)NetworkManageMenu;;
     3)exit 0;;
esac
}
SystemMenu
