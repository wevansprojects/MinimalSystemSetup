#!/bin/bash
echo "Setting Up Simple Nginx Site For Internal Testing"
echo "$(hostname -I) test-site.com" | tee -a /etc/hosts
cat /etc/hosts
