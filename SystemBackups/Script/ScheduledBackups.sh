#!/bin/bash
# Scheduled Backup Script to Server
SERVER="SERVER"
logs="$HOME/SystemBackups/logs"
script="$HOME/SystemBackups/Script"

backup_date=$(date +%d_%m_%Y_%H.%M.%S)
check_connection=$(ping -c3 $SERVER 2>/dev/null)
echo "Checking Connectivity to: $SERVER"
if [[ $check_connection != *"100% packet loss"* && $check_connection = -z ]]; then
     
      echo "SERVER Connected"
      echo ":Running Scripts:"
      echo "Backing Up Home Files"
      $script/./BackupHomeFiles.sh > $logs/Home_backup_$backup_date.log 2>&1
      echo "Backing Up Calibre Files"
      $script/./BackupCalibre.sh > $logs/Calibre_backup_$backup_date.log 2>&1
else
      echo "Unable to connect to SERVER"
      echo "Please Check The Following:"
      echo "-----------------------------------"
      echo "Is the Server Name Correct ?"
      echo "Is the Server Powered On ?"
      echo "Do you have a Network Connection ?"
      echo "Has there been any Server Network or Configuration Changes ?"
      echo "-----------------------------------"
      echo "Exiting Script"
      echo "Bye!!!"
      exit
fi
