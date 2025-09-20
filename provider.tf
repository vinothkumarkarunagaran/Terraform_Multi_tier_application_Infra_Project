terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "multitier/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}

provider "aws" {
  region = var.region
}

