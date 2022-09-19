!# bin/bash

      sudo apt-get update
      sudo apt-get -y install nginx
      sudo systemctl start nginx
      echo '<h1><center>Hello World of Terraform/DevOps</center><h1>'  > index.html
      sudo mv index.html /usr/share/nginx/html


# systemctl status nginx

# cd /var/www
# sudo mkdir tutorial

# sudo "${Editor: -vi}" index.html