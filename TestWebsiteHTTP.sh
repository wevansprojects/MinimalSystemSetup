#!/bin/bash
echo "Seetting Up Simple Nginx Site For Internal Testing"
sudo echo "$(hostname -I) test-site.com" | tee -a /etc/hosts
cat /etc/hosts
