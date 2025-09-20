variable "vpc_id" {
  description = "VPC ID for RDS"
  type        = string
}

variable "db_subnets" {
  description = "List of DB subnet IDs for RDS"
  type        = list(string)
}

variable "db_username" {
  description = "RDS master username"
  type        = string
}

variable "db_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
}

variable "project" {
  description = "Project name prefix for naming"
  type        = string
}

