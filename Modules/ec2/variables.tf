variable "vpc_id" {
  description = "VPC ID where EC2 will be launched"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs for EC2 instances"
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "project" {
  description = "Project name prefix for naming"
  type        = string
}

