#!/bin/bash
echo "Installing nginx and ufw"  
sudo apt install nginx -y
sudo apt install ufw -y
echo "Configuring Firewall Settings"
sudo ufw allow 'Nginx HTTP'
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

echo "Create a simple http configuration file in Nginx"
echo "server {" |sudo tee -a /etc/nginx/sites-available/testsite
echo "listen 80;" |sudo tee -a /etc/nginx/sites-available/testsite
echo "     listen [::]:80;" |sudo tee -a /etc/nginx/sites-available/testsite
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
