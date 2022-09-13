variable "aws_region" {
  description = "region for infrastructure"
  default     = "us-east-1"
}

variable "ami_image" {
  description = "instance image value"
  default     = "ami-08d4ac5b634553e16"
}

variable "instance_type" {
  description = "type of instance to be used"
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "instance security group"
  default     = "subnet-0770f5e2dfff32311"
}

variable "tags" {
  description = "instance resource tag"
  default     = "nginx_vm"
}

variable "vpc_id" {
  description = "id of used VPC"
  default     = "vpc-0f72ba75472a222bb"
}

variable "vpc_cidr" {
  description = "cidr range for selected VPC"
  default     = "172.31.0.0/16"
}

variable "sg_tag" {
  description = "name for security group"
  default     = "nginx_sg"
}