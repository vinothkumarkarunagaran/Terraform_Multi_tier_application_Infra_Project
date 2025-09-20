variable "region" { default = "us-east-1" }
variable "project" { default = "multitier-app" }

variable "vpc_cidr" { default = "10.0.0.0/16" }
variable "public_subnets" { default = ["10.0.1.0/24", "10.0.2.0/24"] }
variable "private_subnets" { default = ["10.0.3.0/24", "10.0.4.0/24"] }
variable "db_subnets" { default = ["10.0.5.0/24", "10.0.6.0/24"] }
variable "azs" { default = ["us-east-1a", "us-east-1b"] }

variable "instance_type" { default = "t3.micro" }
variable "db_username" { default = "admin" }
variable "db_password" { default = "Terraform123!" }

