variable "aws_region" {
  type        = string
  description = "The AWS region where the provider will operate"
}

variable "identifier" {
  type = string
}

variable "repo_url" {
  type = string
}

variable "env" {
  type = string
}

variable "vpc_cidr" {
  type        = string
  description = "The VPC CIDR"
}

variable "enable_dns_hostnames" {
  type = bool
}

variable "enable_dns_support" {
  type = bool
}