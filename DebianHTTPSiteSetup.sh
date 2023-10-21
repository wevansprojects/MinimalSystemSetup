#!/bin/bash
cd $HOME/MinimalSystemSetup
./1_DebianStarterSetup.sh; ./2_bashrchelper.sh; ./3_nginxtestsite.sh
echo "Http Site Setup Script Finished Testing Site"
lynx http://www.testsite.com
