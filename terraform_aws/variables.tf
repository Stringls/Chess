# variable "AWS_ACCESS_KEY_ID" {
#   type        = string
#   description = "AWS Access Key ID"
#   sensitive   = true
# }

# variable "AWS_SECRET_ACCESS_KEY" {
#   type        = string
#   description = "AWS Secret Acess Key"
#   sensitive   = true
# }

variable "aws_region" {
  type        = string
  description = "The AWS region where the provider will operate"
  default     = "eu-central-1"
}

# variable "profile" {
#   type = string
#   description = "The Profile with credentials"
#   default = "~/Chess/.aws/credential"
# }

variable "repo_url" {
  type        = string
  description = "The GitHub Repo URL"
  default     = "https://github.com/Stringls/Chess"
}

variable "identifier" {
  type        = string
  description = "The identifier of all resources"
  default     = "chess"
}

variable "env" {
  type        = string
  description = "The Environment of product"
  default     = "prod"
}

variable "sql_admin_password" {
  type        = string
  description = "The Master Password"
  sensitive   = true
}

# variable "SSH_PUBLIC_KEY" {
#   type = string
#   description = "The SSH Public Key"
#   sensitive = true
# }