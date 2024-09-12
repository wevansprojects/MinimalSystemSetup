#!/bin/bash
#Create a crontab run by root to run through the system setup
crontab -l | { cat; echo "10 14 * * * /bin/bash /tmp/updatesystem.sh"; } | crontab -
