variable "aws_region" {
  description = "region for infrastructure"
  default     = "us-east-1"
}

variable "ami_image" {
  description = "instance image value"
  default     = "ami-052efd3df9dad4825"
}

variable "instance_type" {
  description = "type of instance to be used"
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "instance security group"
  default     = "subnet-0f38923e7c8a0e7a2"
}

variable "tags" {
  description = "instance resource tag"
  default     = "nginx_vm"
}

// This is the given VPC for Cloud Playground
variable "vpc_id" {
  description = "id of used VPC"
  default     = "vpc-0410c5f650766ab1a"
}

# variable "vpc_cidr" {
#   description = "cidr range for selected VPC"
#   default     = "172.31.64.0/20"
# }

variable "vpc_cidr" {
  description = "cidr range for selected VPC"
  default     = "172.31.0.0/16"

}

# variable "vpc_cidr_perso" {
#   description = "cidr range for personal VPC"
#   default     = "172.31.0.0/16"
# }

variable "pub_cidr" {
  description = "cidr range for subnet"
  default     = "172.31.64.0/20"
}

variable "sg_ssh_tag" {
  description = "name for security group"
  default     = "nginx_ssh_sg"
}

variable "sg_https_tag" {
  description = "name for https security group"
  default     = "nginx_https_sg"

}

variable "sub_tag" {
  description = "name for public subnet"
  default     = "public_subnet"

}

variable "ig_id" {
  description = "id value for desired internet gateway"
  default     = "igw-0d2a48b2658242edd"

}