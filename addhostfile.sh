#!/bin/bash
echo "Apending host file with test-site.com"
echo "$(hostname -I) test-site.com" | tee -a /etc/hosts
cat /etc/hosts
