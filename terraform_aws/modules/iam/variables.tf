variable "iam_ec2_role" {
  type        = string
  description = "IAM EC2 Role name"
  default     = "app-ec2-role"
}

variable "iam_intance_profile" {
  type        = string
  description = "IAM Instance Profile name"
  default     = "ec2-profile"
}

variable "iam_eb_role" {
  type        = string
  description = "IAM EB Role name"
  default     = "elasticbeanstalk-service-role"
}

variable "app-attach" {
  type        = string
  description = "The AWS Policy name"
  default     = "app-attach"
}