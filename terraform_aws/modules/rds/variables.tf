variable "rds_identifier" {
  type = string
  description = "AWS RDS Identifier"
  default = "rds-app-prod"
}

variable "db_storage" {
  type = number
  default = 10
  description = "The Max allocated storage"
}

variable "msqql_engine_version" {
  type = string
  default = "14.00.3421.10"
  description = "The SQL Server Express Edition version https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_SQLServer.html#:~:text=quote%20(%27).-,DB%20instance%20class%20support%20for%20Microsoft%20SQL%20Server,-The%20computation%20and"
}

variable "db_instance_class" {
  type = string
  default = "db.t2.micro"
  description = "The DB instance class (db.t2.micro - is a free tier)"
}

variable "sql_admin_username" {
  type = string
  default = "admin"
  description = "The master username"
}

variable "sql_admin_password" {
  type = string
  description = "The master password"
  sensitive = true
}

variable "parameter_group_name" {
  type = string
  description = "Name of the DB parameter group to associate"
  default = "default.mssql"
}

variable "skip_final_snapshot" {
  type = bool
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted"
  default = true
}

