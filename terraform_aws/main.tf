terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.20.1"
    }
  }

  cloud {
    organization = "stringls"

    workspaces {
      name = "gh-action-aws-demo"
    }
  }

  # backend "s3" {
  #   encrypt = true
  #   bucket = "tfstate-s3-bucket"
  #   key = "tfstate"
  #   region = "eu-central-1"
  # }
}

provider "aws" {
  # access_key = var.AWS_ACCESS_KEY_ID
  # secret_key = var.AWS_SECRET_ACCESS_KEY
  region     = "${var.aws_region}"
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

  vpc_cidr             = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
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

######################################################
# BASTION HOST DEFINITION
######################################################

# module "bastion" {
#   source = "umotif-public/bastion/aws"
#   version = "~> 2.1.0"

#   name_prefix = "${var.identifier}-bastion-host"

#   vpc_id         = module.vpc.vpc_id
#   subnets        = ["${module.vpc.public_subnet1_id}", "${module.vpc.public_subnet2_id}"]

#   hosted_zone_id = "Z1IY32BQNIYX16"
#   ssh_key_name   = "${var.SSH_PUBLIC_KEY}"

#   tags = {
#     Project = "Test"
#   }
# }

######################################################
# KMS DEFINITION
######################################################

# module "kms" {
#   source = "./modules/kms"

# }