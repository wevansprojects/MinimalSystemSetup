#!/bin/bash
#Create a crontab run by root to run through the system setup
crontab -l | { cat; echo "30 12 * * * /bin/bash /tmp/updatesystem.sh"; } | crontab -
