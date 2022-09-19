provider "aws" {}

# terraform {
#   backend "s3" {
#     bucket = "cloudusertrtfstate"
#     key = "cloudplayground/terraform.tfstate"
#     region = "us-east-1"
#   }
# }

resource "aws_vpc" "vpc_nginx" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  #   ipv6_cidr_block = var.ipv6_cidr

  tags = {
    "Name" = "nginx_VPC"
  }
}

# data "aws_route" "main_route_table" {
#   route_table_id = aws_default_route_table.route_nginx.id
  # filter {
  #   name   = "association.main"
  #   values = ["true"]
  # }

  # filter {
  #   name   = "vpc_id"
  #   values = [aws_vpc.vpc.id]
  # }
# }

# resource "aws_default_route_table" "route_nginx" {
#   default_route_table_id = data.aws_route.main_route_table

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.nginx_ig.id
#   }

#   tags = {
#     "Name" = "route-table-nginx"
#   }

# }

# resource "aws_route_table" "route_nginx" {
#   vpc_id = aws_vpc.vpc_nginx.id

#   route {
#     cidr_block = "0.0.0.0/0"
#   }

#   tags = {
#     "Name" = "route-table-nginx"
#   }
# }

resource "aws_subnet" "pub_sub" {
  # vpc_id     = aws_vpc.vpc_nginx
  # vpc_id     = aws_vpc.vpc_nginx_personal.id
  vpc_id     = aws_vpc.vpc_nginx.id
  cidr_block = var.pub_cidr

  tags = {
    Name = var.sub_tag
  }
}

# resource "aws_internet_gateway" "nginx_ig" {
#   vpc_id = var.vpc_id

#   tags = {
#     "Name" = "igateway_nginx"
#   }
# }


resource "aws_security_group" "sg_nginx" {
  name        = "nginx_sg_ssh"
  description = "Allow TCP/80 && TCP/22 Traffic"
  vpc_id      = var.vpc_id
  # vpc_id = aws_vpc.vpc_nginx_personal.id


  ingress {
    description = "Allow SSH Traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP Traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    "Name" = var.sg_tag
  }
}

# resource "aws_key_pair" "deployer" {
#   key_name   = "provision_key"
#   public_key = file("~/.ssh/id_rsa.pub")

# }

resource "tls_private_key" "key_pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  # key_name = var.key_name
  public_key = tls_private_key.key_pair.public_key_openssh
}

data "aws_ami" "nginx_ami" {
  owners      = ["099720109477"]
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/*"]
  }

}


resource "aws_instance" "nginx_server" {
  ami           = data.aws_ami.nginx_ami.id
  instance_type = var.instance_type
  # subnet_id     = aws_subnet.pub_sub.id
  subnet_id       = var.subnet_id
  security_groups = [aws_security_group.sg_nginx.id]
  key_name = aws_key_pair.generated_key.key_name


  # connection {
  #   type        = "ssh"
  #   user        = "admin"
  #   private_key = file("~/.ssh/id_rsa")
  #   host        = self.public_ip
  # }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get -y install nginx",
      "sudo systemctl start nginx",
      "echo '<h1><center>Hello World of Terraform/DevOps</center><h1>'  > index.html",
      "sudo mv index.html /usr/share/nginx/html"
    ]
  }

  # user_data = file("files/nginx_install.sh")

  # provisioner "file" {
  #   source = "./web/hello_world.html"
  #   destination = "/var/www/"
  # }

  # depends_on = [
  #   aws_internet_gateway.nginx_ig
  # ]


  tags = {
    Name = var.tags
  }
}


output "nginx_public_ip" {
  value = aws_instance.nginx_server.public_ip
}

output "private_key" {
  value = tls_private_key.key_pair.private_key_pem
  sensitive = true
  
}