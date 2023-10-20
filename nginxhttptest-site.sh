#!/bin/bash
sudo apt install nginx
sudo mkdir -p /var/www/test-site.com/html
sudo chown -R $USER:$USER /var/www/test-site.com/html

echo "Create a Simple Test Site Index Page"
echo "<html>" >> /var/www/test-site.com/html/index.html
echo "<head>" >> /var/www/test-site.com/html/index.html
echo "    <title>Welcome to test-site.com</title>" >> /var/www/test-site.com/html/index.html
echo "</head>" >> /var/www/test-site.com/html/index.html
echo "<body> >> /var/www/test-site.com/html/index.html
echo "    <h1>Success! Your Nginx server is successfully configured for <em>test-site.com</em>. </h1>" >> /var/www/test-site.com/html/index.html
echo "<p>This is a sample page.</p>" >> /var/www/test-site.com/html/index.html
echo "</body>" >> /var/www/test-site.com/html/index.html
echo "</html>" >> /var/www/test-site.com/html/index.html

echo "Create a simple http configuration file in Nginx"
echo "server {" |sudo tee -a /etc/nginx/sites-available/test-site.conf
echo "listen 80;" |sudo tee -a /etc/nginx/sites-available/test-site.conf
echo "     listen [::]:80;" |sudo tee -a /etc/nginx/sites-available/test-site.conf
echo "     root /var/www/terraction/html;" |sudo tee -a /etc/nginx/sites-available/test-site.conf
echo "     index index.html index.htm;" |sudo tee -a /etc/nginx/sites-available/test-site.conf
echo "    server_name www.terraction.com;" |sudo tee -a /etc/nginx/sites-available/test-site.conf
echo " " |sudo tee -a /etc/nginx/sites-available/test-site.conf
echo " location / {" |sudo tee -a /etc/nginx/sites-available/test-site.conf
echo "   try_files $uri $uri/ =404;" >> |sudo tee -a /etc/nginx/sites-available/test-site.conf
echo "  } " |sudo tee -a /etc/nginx/sites-available/test-site.conf
echo " " |sudo tee -a /etc/nginx/sites-available/test-site.conf
echo "}" |sudo tee -a /etc/nginx/sites-available/test-site.conf
echo "Append the Nginx Config File to include the test-site"
echo "include /etc/nginx/conf.d*.conf;" |sudo tee -a /etc/nginx/nginx.conf
echo "include /etc/nginx/sites-enabled/*;" |sudo tee -a /etc/nginx/nginx.conf
echo "Create Symlink to Enable the Site"
sudo ln -s /etc/nginx/sites-available/test-site/test-site.conf /etc/nginx/sites-enabled/test-site.conf
echo "Start Nginx"
sudo systemctl start nginx
sudo systemctl enable nginx
