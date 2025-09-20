terraform {
  backend "s3" {
    bucket         = "vino-s3-bucket-1"
    key            = "multitier/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}

provider "aws" {
  region = var.region
}

