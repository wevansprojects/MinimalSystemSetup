#!/bin/bash
echo "Seetting Up Simple Nginx Site For Internal Testing"
echo "$(hostname -I) test-site.com" | tee /etc/hosts
