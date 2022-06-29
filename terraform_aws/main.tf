terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.20.1"
    }
  }
}

provider "aws" {
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
  region     = var.aws_region
}

######################################################
# IAM ROLES
######################################################

module "iam_roles" {
  source = "./modules/iam"
}

######################################################
# VPC DEFINITION
######################################################

module "vpc" {
  source = "./modules/vpc"

  aws_region = var.aws_region
}

######################################################
# RDS DEFINITION
######################################################

