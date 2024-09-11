#!/bin/bash
#Create a crontab run by root to run through the system setup
crontab -l | { cat; echo "30 18 * * * /bin/bash /tmp/deployrepo.sh"; } | crontab -
