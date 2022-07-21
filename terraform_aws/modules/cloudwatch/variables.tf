variable "identifier" {
  type = string
}

# variable "log_destination" {
#   type        = string
#   description = "The Log destination name"
#   default     = "test_destination"
# }

# variable "iam_for_cloudwatch_arn" {
#   type = string
# }

# variable "kinesis_for_cloudwatch_arn" {
#   type = string
# }

variable "dashboard_name" {
  type = string
  default = null
  description = "The Test Dashboard name"
}