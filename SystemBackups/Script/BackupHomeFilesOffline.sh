#!/bin/bash

CONFIG_PATH=$(grep "CONFIG_PATH" $HOME/SystemBackups/conf/backupconf| cut -d ":" -f2)
HOME_DIR=$(grep "HOME_DIR:" $CONFIG_PATH| cut -d ":" -f2)
ARCHIVE_FOLDER=$(grep "ARCHIVE_FOLDER:" $CONFIG_PATH| cut -d ":" -f2)
HOME_EXCLUSIONS=$(grep "HOME_EXCLUSIONS:" $CONFIG_PATH| cut -d ":" -f2)
ROOT_VAR_EXCLUSIONS=$(grep "ROOT_VAR_EXCLUSIONS:" $CONFIG_PATH| cut -d ":" -f2)

echo "Checking for $ARCHIVE_FOLDER"
if [ ! -d "$ARCHIVE_FOLDER" ]; then
      mkdir "$ARCHIVE_FOLDER"
fi

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

chmod u+x backupscript.sh
./backupscript.sh
cd $HOME
rm -rf $ARCHIVE_FOLDER$bdate
echo "All Offline Backups Completed Check The Folder: $ARCHIVE_FOLDER for Results" 
