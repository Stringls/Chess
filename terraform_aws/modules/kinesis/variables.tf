variable "identifier" {
  type        = string
  description = "The global identifier of resource naming"
}

variable "kinesis_name" {
  type        = string
  description = "The AWS Kinesis stream name"
  default     = "kinesis-test"
}

variable "shard_count" {
  type        = number
  description = "The number of shards that the stream will use"
  default     = 1
}

variable "retention_period" {
  type        = number
  description = "Length of time data records are accessible after they are added to the stream"
  default     = 48
}

variable "stream_mode" {
  type        = string
  description = "Specifies the capacity mode of the stream"
  default     = "PROVISIONED"
}

variable "env" {
  type = string
}

variable "repo_url" {
  type = string
}