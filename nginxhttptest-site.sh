#!/bin/bash
sudo apt install nginx
sudo mkdir -p /var/www/test-site.com/html
sudo chown -R $USER:$USER /var/www/test-site.com/html
echo "<html>" >> /var/www/test-site.com/html/index.html
echo "<head>" >> /var/www/test-site.com/html/index.html
echo "    <title>Welcome to www.terractive.com</title>" >> /var/www/test-site.com/html/index.html
echo "</head>" >> /var/www/test-site.com/html/index.html
echo "<body> >> /var/www/test-site.com/html/index.html
echo "    <h1>Success! Your Nginx server is successfully configured for <em>test-site.com</em>. </h1>" >> /var/www/test-site.com/html/index.html
echo "<p>This is a sample page.</p>" >> /var/www/test-site.com/html/index.html
echo "</body>" >> /var/www/test-site.com/html/index.html
echo "</html>" >> /var/www/test-site.com/html/index.html
