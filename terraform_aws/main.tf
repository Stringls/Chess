terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.20.1"
    }
  }

  #  backend "s3" {}
}

provider "aws" {
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
  region     = var.aws_region
}

######################################################
# IAM ROLES
######################################################

module "iam" {
  source = "./modules/iam"
}

######################################################
# VPC DEFINITION
######################################################

module "vpc" {
  source = "./modules/vpc"

  identifier = var.identifier
  env        = var.env
  repo_url   = var.repo_url

  aws_region = var.aws_region
}

######################################################
# RDS DEFINITION
######################################################

module "rds" {
  source = "./modules/rds"

  identifier         = var.identifier
  env                = var.env
  repo_url           = var.repo_url
  sql_admin_password = var.sql_admin_password

  # vpc output
  vpc_id      = module.vpc.vpc_id
  subnet_1_id = module.vpc.subnet_1_id
  subnet_2_id = module.vpc.subnet_2_id

  # eb output
  eb_security_group_id = module.eb.eb_security_group_id
}

######################################################
# EB DEFINITION
######################################################

module "eb" {
  source = "./modules/eb"

  identifier = var.identifier
  env        = var.env
  repo_url   = var.repo_url

  # rds output
  db_instance_password = var.sql_admin_password
  db_instance_endpoint = module.rds.db_instance_endpoint
  db_instance_username = module.rds.db_instance_username

  # vpc output
  vpc_id             = module.vpc.vpc_id
  subnet_private1_id = module.vpc.subnet_1_id
  subnet_private2_id = module.vpc.subnet_2_id
  public_subnet1_id  = module.vpc.public_subnet1_id
  public_subnet2_id  = module.vpc.public_subnet2_id

  # iam output
  eb_service_role = module.iam.eb_service_role
  ec2_role        = module.iam.ec2_role
}