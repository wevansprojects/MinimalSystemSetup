#!/bin/bash
cd $HOME/MinimalSystemSetup/DebianSetup/HTTPServer/SetupScripts
sudo chmod u+x *.sh
./1_Prerequisites.sh; ./2_bashrchelper.sh; ./3_nginxhttptestsite.sh
echo "Http Site Setup Script Finished Testing Site"
echo "To test please type: lynx http://www.testsite.com or http://testsite.com"
exec bash
