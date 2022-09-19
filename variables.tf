variable "aws_region" {
  description = "region for infrastructure"
  default     = "us-east-1"
}

variable "key_name" {
  description = "name of key"
  default     = "webserver_key"

}

variable "vpc_cidr" {
  description = "cidr range for webserver vpc"
  default     = "10.0.0.0/16"
}

variable "vpc_tag" {
  description = "name for VPC"
  default     = "nginx-vpc"
}

variable "subnet_cidr" {
  description = "cidr range for webserver vpc"
  default     = "10.0.1.0/24"
}

variable "instance_type" {
  description = "type of instance desired"
  default     = "t3.micro"
}

variable "instance_tag" {
  description = "name for instance"
  default     = "nginx_webserver"

}




















# variable "ami_image" {
#   description = "instance image value"
#   default     = "ami-052efd3df9dad4825"
# }

# variable "instance_type" {
#   description = "type of instance to be used"
#   default     = "t2.micro"
# }

# variable "subnet_id" {
#   description = "instance security group"
#   default     = "subnet-0e08d43043dfbf9d2"
# }

# variable "tags" {
#   description = "instance resource tag"
#   default     = "nginx_vm"
# }

# // This is the given VPC for Cloud Playground
# variable "vpc_id" {
#   description = "id of used VPC"
#   default     = "vpc-0618c027cb0648ef8"
# }

# # variable "vpc_cidr" {
# #   description = "cidr range for selected VPC"
# #   default     = "172.31.64.0/20"
# # }

# variable "vpc_cidr" {
#   description = "cidr range for selected VPC"
#   default     = "172.31.0.0/16"

# }

# # variable "vpc_cidr_perso" {
# #   description = "cidr range for personal VPC"
# #   default     = "172.31.0.0/16"
# # }

# variable "pub_cidr" {
#   description = "cidr range for subnet"
#   default     = "172.31.64.0/20"
# }

# variable "sg_tag" {
#   description = "name for security group"
#   default     = "port 22 && 80"
# }

# variable "sub_tag" {
#   description = "name for public subnet"
#   default     = "public_subnet"

# }

# variable "ig_id" {
#   description = "id value for desired internet gateway"
#   default     = "igw-0d2a48b2658242edd"

# }

# variable "key_name" {}