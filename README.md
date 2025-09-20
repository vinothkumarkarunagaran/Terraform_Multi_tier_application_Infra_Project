# Terraform Multi-Tier AWS Infrastructure

This project provisions a **production-like AWS environment** using Terraform:
- VPC with public, private, and DB subnets
- EC2 Auto-scaled web servers
- Application Load Balancer (ALB)
- RDS MySQL Database
- Remote backend using S3 + DynamoDB

## 🚀 Steps to Deploy
```bash
terraform init
terraform plan
terraform apply

## step to destroy

terraform destroy


📌 Architecture

                ┌─────────────────────────────┐
                │         Internet             │
                └──────────────┬───────────────┘
                               │
                     ┌─────────▼─────────┐
                     │   ALB (Public)    │
                     └─────────┬─────────┘
                               │
              ┌────────────────┴────────────────┐
              │                                 │
      ┌───────▼────────┐               ┌───────▼────────┐
      │ EC2 App Server │               │ EC2 App Server │
      │ (Private Sub)  │               │ (Private Sub)  │
      └───────┬────────┘               └───────┬────────┘
              │                                 │
              └────────────────┬────────────────┘
                               │
                        ┌──────▼──────┐
                        │   RDS DB    │
                        │ (DB Subnet) │
                        └─────────────┘


📂 Folder Structure

terraform-multitier/
├── provider.tf
├── variables.tf
├── main.tf
├── outputs.tf
├── README.md
└── modules/
    ├── vpc/
    ├── ec2/
    ├── alb/
    └── rds/
