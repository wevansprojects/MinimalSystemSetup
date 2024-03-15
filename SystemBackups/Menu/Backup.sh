#!/bin/bash

function osdetails()
{
clear      
result=$(hostnamectl);
whiptail --title "Host Information " --msgbox "$result" 0 0 3>&1 1>&2 2>&3
SystemMenu
}

function homesize {
      clear
      maindir=$(pwd)
      result=$(cd $HOME;du -hc --max-depth=1  2>&1 | grep -v 'denied' |sort -rh) 
whiptail --title "Home Folder Disk Usage:" --msgbox "$result" 0 0 3>&1 1>&2 2>&3
BackupHome
}

function checkbackupfile(){
clear
maindir=$(pwd)
result=$(cat $HOME/SystemBackups/conf/backupconf) 
whiptail --title "Home Folder Disk Usage:" --msgbox "$result" 0 0 3>&1 1>&2 2>&3
BackupHome     
}

function editbackupfile(){
rm $HOME/SystemBackups/conf/backupconf/backupconf 2>/dev/null    
cp $HOME/SystemBackups/conf/backupconf $HOME/Scripts/Bash/SystemBackups/conf/backup/
vim $HOME/SystemBackups/conf/backupconf      
BackupHome
}

function backup {
      rm -rf $HOME/Downloads/archives
      mkdir $HOME/Downloads/archives
      $HOME/SystemBackups/Script/./ScheduledBackups.sh
      BackupHome
}

function BackupHome(){
 MNU=$(whiptail --title ":Personal Backup Menu:" --menu "Select options" 15 60 8 \
"1" "Home Folder Disk Usage" \
"2" "Check Backup File" \
"3" "Edit Backup File"   \
"4" "Backup Home Folder"   \
"5" "Back To Main Menu"   3>&1 1>&2 2>&3)

case $MNU in
     1)homesize;;
     2)checkbackupfile;;
     3)editbackupfile;;
     4)backup;;
     5)SystemMenu;; 

esac
}

function SystemMenu() {
 MNU=$(whiptail --title ":System Backup Menu:" --menu "Select options" 15 60 8 \
"1" "Host Information" \
"2" "Home Drive Backup" \
"3" "Exit" 3>&1 1>&2 2>&3)

case $MNU in
     1)osdetails;;
     2)BackupHome;;
     3)exit 0;;
esac
}
SystemMenu
