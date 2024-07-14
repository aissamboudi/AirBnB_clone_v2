#!/usr/bin/env bash
# Sets up a web server for deployment of web_static.

sudo apt-get update
sudo apt-get install -y nginx
sudo ufw allow 'Nginx HTTP'

mkdir -p /data/web_static/releases/test/
mkdir -p /data/web_static/shared/
echo "Holberton School" > /data/web_static/releases/test/index.html
ln -sf /data/web_static/releases/test/ /data/web_static/current
chown -R ubuntu /data/
chgrp -R ubuntu /data/

sudo sed -i "s/server_name _;/server_name _;\n\trewrite ^\/redirect_me https:\/\/www.youtube.com\/watch?v=QH2-TGUlwu4 permanent;\n\n\terror_page 404 \/404.html;\n\tlocation \/hbnb_static {\n\t\talias \/data\/web_static\/current;\n\t\tindex index.html index.htm;\n\t}\n\tlocation = \/404.html {\n\t\troot \/var\/www\/html;\n\t\tinternal;\n\t}/" /etc/nginx/sites-available/default
sudo sed -i "s/include \/etc\/nginx\/sites-enabled\/\*;/include \/etc\/nginx\/sites-enabled\/\*;\n\tadd_header X-Served-By \"$HOSTNAME\";/" /etc/nginx/nginx.conf
sudo service nginx start
sudo systectl reload nginx
