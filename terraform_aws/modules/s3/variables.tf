variable "identifier" {
  type = string
}

variable "rule_id" {
  type = string
  default = "clean-up"
}

variable "lifecycle_rule_status" {
  type = string
  default = "Enabled"
}

variable "lifecycle_expiration" {
  type = number
  default = 30
}