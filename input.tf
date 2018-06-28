# Provider variables

variable "aws_region" {
  description = "The region the infrastructure is deployed to"
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "The aws profile (credential set) used by terraform"
  default     = "default"
}

# Variables to be assigned in demo-project
variable "vpc_id" {
  #   default = "vpc-a7f01edd"
}

variable "instance_size" {
  #   default = "t2.micro"
}

variable "subnet_id" {
  #   default = "subnet-c37011cc"
}

variable "keyname" {
  #   default = "demo"
}
