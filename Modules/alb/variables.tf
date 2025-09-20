variable "vpc_id" {
  description = "VPC ID where ALB will be created"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet IDs for ALB"
  type        = list(string)
}

variable "target_ids" {
  description = "List of EC2 instance IDs to attach to ALB target group"
  type        = list(string)
}

variable "project" {
  description = "Project name prefix for naming"
  type        = string
}

