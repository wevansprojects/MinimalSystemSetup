#!/bin/bash
sudo apt update
sudo apt install fail2ban
cd /etc/fail2ban
sudo cp $HOME/MinimalSystemSetup/fail2ban/jail.local /etc/fail2ban/jail.local
sudo cp $HOME/MinimalSystemSetup/fail2ban/filter.d/nginx-badbots.conf /etc/fail2ban/filter.d/
sudo cp $HOME/MinimalSystemSetup/fail2ban/filter.d/nginx-nohome.conf /etc/fail2ban/filter.d/
sudo cp $HOME/MinimalSystemSetup/fail2ban/filter.d/nginx-noproxy.conf /etc/fail2ban/filter.d/
sudo cp $HOME/MinimalSystemSetup/fail2ban/defaults-debian.conf /etc/fail2ban/jail.d
sudo mkdir /var/log/nginx/
sudo touch /var/log/nginx/error.log
sudo touch /var/log/nginx/access.log
sudo systemctl restart fail2ban.service
