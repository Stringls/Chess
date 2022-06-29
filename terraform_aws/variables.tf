variable "AWS_ACCESS_KEY_ID" {
  type        = string
  description = "AWS Access Key ID"
  sensitive   = true
}

variable "AWS_SECRET_ACCESS_KEY" {
  type        = string
  description = "AWS Secret Acess Key"
  sensitive   = true
}

variable "aws_region" {
  type        = string
  description = "The AWS region where the provider will operate"
  default     = "eu-central-1"
}

variable "repo_url" {
  type = string
  description = "The GitHub Repo URL"
  default = "https://github.com/Stringls/Chess"
}