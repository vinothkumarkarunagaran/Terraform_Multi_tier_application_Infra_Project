module "vpc" {
  source          = "./modules/vpc"
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  db_subnets      = var.db_subnets
  azs             = var.azs
  project         = var.project
}

module "ec2" {
  source          = "./modules/ec2"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  instance_type   = var.instance_type
  project         = var.project
}

module "alb" {
  source         = "./modules/alb"
  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  target_ids     = module.ec2.instance_ids
  project        = var.project
}

module "rds" {
  source      = "./modules/rds"
  vpc_id      = module.vpc.vpc_id
  db_subnets  = module.vpc.db_subnets
  db_username = var.db_username
  db_password = var.db_password
  project     = var.project
}

