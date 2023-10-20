#!/bin/bash
echo "#Nginx Test and Reload Alias Commands" >> .bashrc
echo "alias nt='sudo nginx -t'" >> .bashrc
echo "alias nr='sudo systemctl reload nginx.service' " >> .bashrc
echo " " >> .bashrc
echo "#PHP Service Reload Alias" >> .bashrc
echo "alias phpr='sudo systemctl reload php8.2-fpm.service'" >> .bashrc
echo " " >> .bashrc
echo "#Trash CLI Alias (prevention of rm usage)" >> .bashrc
echo "alias tp='sudo trash-put'" >> .bashrc
echo "alias tl='sudo trash-list'" >> .bashrc
echo "alias tr='sudo trash-restore'" >> .bashrc
echo "alias te='sudo trash-empty'" >> .bashrc
echo "alias rm='echo "try using trash-cli commands instead! example: trash-put"'" >> .bashrc
