#!/bin/bash
echo "Creating the Certificates"
mkdir $HOME/openssl
cp self-signed-cert.sh $HOME/openssl
cd $HOME/openssl
sudo chmod u+x self-signed-cert.sh
./self-signed-cert.sh testsite.com 
sudo cp rootCA.crt /usr/local/share/ca-certificates
sudo cp testsite.com.crt testsite.com.key /etc/ssl
sudo update-ca-certificates
sudo trash-put $HOME/openssl
sudo trash-empty
echo "Installing nginx and ufw"  
sudo apt install nginx -y
sudo apt install ufw -y
echo "Configuring Firewall Settings"
sudo ufw allow 'Nginx HTTPS'
sudo ufw status
sudo systemctl enable ufw
sudo systemctl start ufw
sudo ufw enable
sudo mkdir -p /var/www/testsite/html
sudo chown -R $USER:$USER /var/www/testsite/html

echo "Create a Simple Test Site Index Page"
echo "<html>" >> /var/www/testsite/html/index.html
echo "<head>" >> /var/www/testsite/html/index.html
echo "    <title>Welcome to testsite.com</title>" >> /var/www/testsite/html/index.html
echo "</head>" >> /var/www/testsite/html/index.html
echo "<body>" >> /var/www/testsite/html/index.html
echo "    <h1>Success! Your Nginx server is successfully configured for <em>testsite.com</em>. </h1>" >> /var/www/testsite/html/index.html
echo "<p>This is a sample page.</p>" >> /var/www/testsite/html/index.html
echo "</body>" >> /var/www/testsite/html/index.html
echo "</html>" >> /var/www/testsite/html/index.html

echo "Create a simple https configuration file in Nginx"
echo "server {" |sudo tee -a /etc/nginx/sites-available/testsite
echo " " |sudo tee -a /etc/nginx/sites-available/testsite
echo "listen 443 ssl;" |sudo tee -a /etc/nginx/sites-available/testsite
echo " " |sudo tee -a /etc/nginx/sites-available/testsite
echo "ssl_certificate    /etc/ssl/testsite.com.crt;" |sudo tee -a /etc/nginx/sites-available/testsite
echo "ssl_certificate_key    /etc/ssl/testsite.com.key;" |sudo tee -a /etc/nginx/sites-available/testsite
echo "     root /var/www/testsite/html;" |sudo tee -a /etc/nginx/sites-available/testsite
echo "     index index.html index.htm nginx-debian.html;" |sudo tee -a /etc/nginx/sites-available/testsite
echo "    server_name testsite www.testsite.com;" |sudo tee -a /etc/nginx/sites-available/testsite
echo " " |sudo tee -a /etc/nginx/sites-available/testsite
echo " location / {" |sudo tee -a /etc/nginx/sites-available/testsite
echo "   try_files \$uri \$uri/ =404;" |sudo tee -a /etc/nginx/sites-available/testsite
echo "  } " |sudo tee -a /etc/nginx/sites-available/testsite
echo " " |sudo tee -a /etc/nginx/sites-available/testsite
echo "}" |sudo tee -a /etc/nginx/sites-available/testsite
echo "Append the Nginx Config File to include the testsite"
echo "Create Symlink to Enable the Site"
sudo ln -s /etc/nginx/sites-available/testsite /etc/nginx/sites-enabled/testsite

echo "Remove the default site link"
sudo trash-put /etc/nginx/sites-enabled/default 
sudo trash-empty

echo "Start Nginx"
sudo systemctl start nginx
sudo systemctl enable nginx.service
sudo systemctl reload nginx.service
