#!/usr/bin/env bash
# Sets up a web server for deployment of web_static.

sudo apt-get update
sudo apt-get install -y nginx
sudo ufw allow 'Nginx HTTP'

mkdir -p /data/web_static/releases/test/
mkdir -p /data/web_static/shared/
echo "Holberton School" > /data/web_static/releases/test/index.html
ln -sf /data/web_static/releases/test/ /data/web_static/current
chown -R ubuntu:ubuntu /data/
chgrp -R ubuntu:ubuntu /data/

sudo sed -i "s/server_name _;/server_name _;\n\tlocation \/hbnb_static {\n\t\talias \/data\/web_static\/current;\n\t\tindex index.html index.htm;\n\t}/" /etc/nginx/sites-available/default

sudo systemctl reload nginx
