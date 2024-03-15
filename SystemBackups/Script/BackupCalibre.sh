#!/bin/bash
CONFIG_PATH=$(grep "CONFIG_PATH" "$HOME/SystemBackups/conf/backupconf"| cut -d ":" -f2)
HOME_DIR=$(grep "HOME_DIR:" $CONFIG_PATH| cut -d ":" -f2)
ARCHIVE_FOLDER=$(grep "ARCHIVE_FOLDER:" $CONFIG_PATH| cut -d ":" -f2)

calibre="$HOME/Calibre Library/"
bdate=$(date +%d_%m_%Y_%H.%M.%S)
clear
cd "$ARCHIVE_FOLDER"
cb="Calibre_Backup_$bdate"
mkdir "$cb"
cd $cb
touch backupscript.sh
echo "#!/bin/bash" >> backupscript.sh
echo "GZIP=-9 tar -cpzf calibre.tar.gz \"$calibre\" 2>/dev/null" >> backupscript.sh
echo "trap \"echo Exited!; exit;\" SIGINT SIGTERM" >> backupscript.sh
echo "RETRIES=15" >> backupscript.sh
echo "i=0" >> backupscript.sh
echo "false" >> backupscript.sh
echo "while [ \$? -ne 0 -a \$i -lt \$RETRIES ]" >> backupscript.sh
echo "do" >> backupscript.sh
echo "i=$(($i+1))" >> backupscript.sh
echo "rsync -rv $ARCHIVE_FOLDER$cb /run/user/1000/gvfs/smb-share:server=server,share=fileshare/Calibre_Backups" >> backupscript.sh
echo "done" >> backupscript.sh
echo "if [ \$i -eq \$RETRIES ]" >> backupscript.sh
echo "then" >> backupscript.sh
echo " echo \"Hit maximum number of retries, giving up.\"" >> backupscript.sh
echo "fi" >> backupscript.sh

chmod u+x backupscript.sh
./backupscript.sh
cd $HOME
rm -rf $ARCHIVE_FOLDER$cb
