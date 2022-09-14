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
  default     = "subnet-0cc8eebf581ef0b70"
}

variable "tags" {
  description = "instance resource tag"
  default     = "nginx_vm"
}

variable "vpc_id" {
  description = "id of used VPC"
  default     = "vpc-0771d68c9d4e097bf"
}

variable "vpc_cidr" {
  description = "cidr range for selected VPC"
  default     = "172.31.64.0/20"
}

variable "sg_ssh_tag" {
  description = "name for security group"
  default     = "nginx_ssh_sg"
}

variable "sg_https_tag" {
  description = "name for https security group"
  default = "nginx_https_sg"
  
}

variable "subnet_cidr" {
  description = "cidr range for subnet"
  default     = "172.31.0.0/14"

}