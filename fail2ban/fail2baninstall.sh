#!/bin/bash
sudo apt update
sudo apt install fail2ban
sudo systemctl status fail2ban.service
cd /etc/fail2ban
sudo cp jail.conf jail.local
sudo cp jail.conf jail.conf
sudo cp filter.d/nginx-badbots.conf /etc/fail2ban/filter.d/
sudo cp filter.d/nginx-nohome.conf /etc/fail2ban/filter.d/
sudo cp filter.d/nginx-noproxy.conf /etc/fail2ban/filter.d/
sudo cp defaults-debian.conf /etc/fail2ban/defaults-debian.conf /etc/fail2ban/jail.d
sudo mkdir /var/log/nginx/
sudo touch /var/log/nginx/error.log
sudo touch /var/log/nginx/access.log
sudo systemctl restart fail2ban.service

