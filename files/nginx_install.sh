#!/bin/bash

sudo apt-get update
sudo apt-get install nginx
sudo systemctl start nginx 

# cd /var/www
# sudo mkdir tutorial

# sudo "${Editor: -vi}" index.html