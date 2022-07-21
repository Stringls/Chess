# You must first create a public key and a private key by execution ssh-keygen command
# variable "SSH_PUBLIC_KEY" {
#   type        = string
#   description = "SSH Public Key to connect to EC2 instance"
#   default = "~/.ssh/id_rsa.pub"
# }

variable "vpc_id" {
  type        = string
  description = "The VPC id"
}

variable "eb_identifier" {
  type        = string
  default     = "app-prod"
  description = "The EB Identifier"
}

variable "identifier" {
  type = string
}

variable "env" {
  type = string
}

variable "repo_url" {
  type = string
}

variable "associate_public_ip_address" {
  type        = bool
  default     = true
  description = "Associate EB with public ip address"
}

# variable "elb_scheme" {
#   type        = string
#   default     = "public"
#   description = "The ELB Scheme"
# }

# variable "cross_zone" {
#   type        = string
#   default     = "true"
#   description = " If cross-zone load balancing is disabled, each load balancer node distributes requests evenly across the registered instances in its Availability Zone only"
# }

# variable "batch_size" {
#   type        = string
#   default     = "30"
#   description = "The number of records to send to the function in each batch"
# }

# variable "batch_size_type" {
#   type        = string
#   default     = "Percentage"
#   description = "The Batch Size type"
# }

variable "availability_zones" {
  type        = string
  default     = "Any 2"
  description = "An Auto Scaling group can contain EC2 instances in one or more Availability Zones within the same Region"
}

variable "min_size" {
  type        = string
  default     = "1"
  description = "Capacity limits place restrictions on the size of your Auto Scaling group"
}

variable "rolling_update_type" {
  type        = string
  default     = "Health"
  description = "How AWS CloudFormation handles rolling updates for an Auto Scaling group"
}

variable "db_instance_address" {
  type        = string
  description = "The DB instance Endpoint"
}

variable "db_instance_username" {
  type        = string
  description = "The DB Master's username"
}

variable "db_instance_password" {
  type        = string
  description = "The DB Master's password"
}

# variable "subnet_private1_id" {
#   type        = string
#   description = "The PRIVATE Subnet 1 Id"
# }

# variable "subnet_private2_id" {
#   type        = string
#   description = "The PRIVATE Subnet 2 Id"
# }

variable "public_subnet1_id" {
  type        = string
  description = "The PUBLIC subnet 1 id"
}

variable "public_subnet2_id" {
  type        = string
  description = "The PUBLIC subnet 2 id"
}

variable "eb_service_role" {
  type        = string
  description = "The IAM EB Service Role"
}

variable "eb_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "The EB instance type"
}

variable "ec2_role" {
  type        = string
  description = "The EC2 Service Role"
}

variable "solution_stack_name" {
  type        = string
  description = "The Solution Stack Name (The platform on which the server will run)"
  default     = "64bit Amazon Linux 2 v2.3.3 running .NET Core"
}

variable "enable_log_publication_control" {
  type        = bool
  default     = false
  description = "Copy the log files for your application's Amazon EC2 instances to the Amazon S3 bucket associated with your application"
}

variable "enable_stream_logs" {
  type        = bool
  default     = false
  description = "Whether to create groups in CloudWatch Logs for proxy and deployment logs, and stream logs from each instance in your environment"
}

variable "logs_delete_on_terminate" {
  type        = bool
  default     = true
  description = "Whether to delete the log groups when the environment is terminated. If false, the logs are kept RetentionInDays days"
}

variable "logs_retention_in_days" {
  type        = number
  default     = 7
  description = "The number of days to keep log events before they expire."
}

variable "health_streaming_enabled" {
  type        = bool
  default     = false
  description = "For environments with enhanced health reporting enabled, whether to create a group in CloudWatch Logs for environment health and archive Elastic Beanstalk environment health data. For information about enabling enhanced health, see aws:elasticbeanstalk:healthreporting:system."
}

variable "health_streaming_delete_on_terminate" {
  type        = bool
  default     = true
  description = "Whether to delete the log group when the environment is terminated. If false, the health data is kept RetentionInDays days."
}

variable "health_streaming_retention_in_days" {
  type        = number
  default     = 7
  description = "The number of days to keep the archived health data before it expires."
}