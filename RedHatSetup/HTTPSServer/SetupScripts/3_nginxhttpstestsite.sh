#!/bin/bash

echo "Setup and Apply the Self Signed Certificate"
sudo mkdir -p /etc/nginx/ssl
mkdir $HOME/openssl
cp self-signed-cert.sh $HOME/openssl
#cd $HOME/openssl
sudo chmod u+x $HOME/openssl/self-signed-cert.sh
$HOME/openssl/./self-signed-cert.sh testsite.com 
sudo cp $HOME/openssl/rootCA.crt /etc/pki/ca-trust/source/anchors/
sudo cp $HOME/openssl/testsite.com.crt testsite.com.key /etc/nginx/ssl
sudo update-ca-trust
#cd $HOME/MinimalSystemSetup/RedHatSetup/HTTPSServer/SetupScripts/

#cd /tmp/MinimalSystemSetup/RedHatSetup/HTTPSServer/SetupScripts/
echo "Setting up nginx test site and permissions"
sudo mkdir -p /var/www/testsite.com/html
sudo chmod -R 755 /var/www/testsite.com
sudo chown -R nginx:nginx /var/www/testsite.com/
sudo chown nginx:nginx index.html
sudo cp -p index.html /var/www/testsite.com/html
sudo chown root:root testsite.com.conf 
sudo cp -p testsite.com.conf /etc/nginx/conf.d/

echo "Adding HTTPS Firewall Rules"
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload

echo "SELinux Rules"
# httpd_can_network_connect 
# allows the Nginx server (under SELinux's httpd context) to 
# a. make network connections, required for SSL.
# b. Label the SSL Certificate Directory
# Ensure the SSL certificate files are labeled correctly for Nginx to read them
# semanage fcontext assigns the SELinux type httpd_sys_content_t to all files within the /etc/nginx/ssl/ directory.
# restorecon applies the correct SELinux context to these files.
# c. Label the Web Root Directory
# Similarly, make sure your website's root directory is correctly labeled for Nginx
sudo setsebool -P httpd_can_network_connect 1
sudo semanage fcontext -a -t httpd_sys_content_t "/etc/nginx/ssl(/.*)?"
sudo restorecon -Rv /etc/nginx/ssl
# The below ensures SELinux allows Nginx to serve files from your websites directory.
sudo semanage fcontext -a -t httpd_sys_content_t "/var/www/testsite.com(/.*)?"
sudo restorecon -Rv /var/www/testsite.com 

echo "Enable and startup nginx"
echo "Remove Old Cert Folder"
sudo trash-put $HOME/openssl
sudo trash-empty
echo "Start Nginx"
sudo systemctl enable nginx
sudo systemctl start nginx
#lynx https://testsite.com/
