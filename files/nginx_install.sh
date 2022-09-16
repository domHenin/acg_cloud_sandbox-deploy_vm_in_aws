!# bin/bash

sudo apt-get update
sudo apt-get -y install nginx
sudo systemctl start nginx


# systemctl status nginx

# cd /var/www
# sudo mkdir tutorial

# sudo "${Editor: -vi}" index.html