#!/bin/bash
cd $HOME/MinimalSystemSetup/DebianSetup/HTTPSServer/SetupScripts
sudo chmod u+x *.sh
./1_Prerequisites.sh; ./2_bashrchelper.sh; ./3_nginxhttpstestsite.sh
echo "Http Site Setup Script Finished Testing Site"
echo "To test please type: lynx http://www.testsite.com or http://testsite.com"
exec bash
