#!/bin/bash

echo "Setup a self signed certificate"
sudo mkdir -p /etc/nginx/ssl
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/testsite.com.key -out /etc/nginx/ssl/testsite.com.crt \
  -subj "/C=US/ST=State/L=City/O=Organization/OU=OrgUnit/CN=testsite.com"

echo "Setting up nginx test site and permissions"
sudo mkdir -p /var/www/testsite.com/html
sudo chmod -R 755 /var/www/testsite.com
sudo chown -R nginx:nginx /var/www/testsite.com/html
sudo chown nginx:nginx index.html
sudo cp -p index.html /var/www/testsite.com
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

echo "Add Self Signed Certificate As Trusted Cert"
sudo cp testsite.com.crt /etc/pki/ca-trust/source/anchors/
sudo update-ca-trust

echo "Enable and startup nginx"
sudo systemctl enable nginx
sudo systemctl start nginx
