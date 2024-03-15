#!/bin/bash
CONFIG_PATH=$(grep "CONFIG_PATH" "$HOME/SystemBackups/conf/backupconf"| cut -d ":" -f2)
HOME_DIR=$(grep "HOME_DIR:" $CONFIG_PATH| cut -d ":" -f2)
ARCHIVE_FOLDER=$(grep "ARCHIVE_FOLDER:" $CONFIG_PATH| cut -d ":" -f2)
HOME_EXCLUSIONS=$(grep "HOME_EXCLUSIONS:" $CONFIG_PATH| cut -d ":" -f2)
ROOT_VAR_EXCLUSIONS=$(grep "ROOT_VAR_EXCLUSIONS:" $CONFIG_PATH| cut -d ":" -f2)

nvimrc="$HOME/.config/nvim/init.vim"
vimrc="$HOME/.vimrc"
zshrc="$HOME/.zshrc"
bashrc="$HOME/.bashrc"
powerlevelzsh="$HOME/.p10k.zsh"
lf="$HOME/.config/lf/lfrc"
bdate=$(date +%d_%m_%Y_%H.%M.%S)
clear
cd "$ARCHIVE_FOLDER"
mkdir "$bdate"
mkdir "$bdate/Scripts"
cd $bdate
touch backupscript.sh
echo "#!/bin/bash" >> backupscript.sh
echo "tar -cpzf userhomefolderbackup.tar.gz --exclude={$HOME_EXCLUSIONS} $HOME_DIR 2>/dev/null" >> backupscript.sh
echo "tar -cpzf termconfigs.tar.gz $nvimrc $vimrc $zshrc $bashrc $powerlevelzsh $lf 2>/dev/null" >> backupscript.sh

Scripts=$(ls "$HOME/Scripts")
for i in $Scripts; do      
    echo "tar -cpzf $ARCHIVE_FOLDER$bdate/Scripts/$i.tar.gz $HOME/Scripts/$i 2>/dev/null " >> backupscript.sh
done

echo "trap \"echo Exited!; exit;\" SIGINT SIGTERM" >> backupscript.sh
echo "RETRIES=15" >> backupscript.sh
echo "i=0" >> backupscript.sh
echo "false" >> backupscript.sh
echo "while [ \$? -ne 0 -a \$i -lt \$RETRIES ]" >> backupscript.sh
echo "do" >> backupscript.sh
echo "i=$(($i+1))" >> backupscript.sh
echo "rsync -rv $ARCHIVE_FOLDER$bdate /run/user/1000/gvfs/smb-share:server=server,share=fileshare/Backups" >> backupscript.sh

echo "done" >> backupscript.sh
echo "if [ \$i -eq \$RETRIES ]" >> backupscript.sh
echo "then" >> backupscript.sh
echo " echo \"Hit maximum number of retries, giving up.\"" >> backupscript.sh
echo "fi" >> backupscript.sh

chmod u+x backupscript.sh
./backupscript.sh
 cd $HOME
 rm -rf $ARCHIVE_FOLDER$bdate
