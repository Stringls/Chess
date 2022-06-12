variable "project_name" {
  type        = string
  description = "The name of the application"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group name"
  default     = ".net_chess_project"
}

variable "resource_group_location" {
  type        = string
  description = "Resource Group location"
  default     = "North Europe"
}

variable "sql_database_name" {
  type        = string
  description = "SQL Database name"
  default     = "Chess"
}

variable "sql_admin_login" {
  type        = string
  description = "SQL Server login name in Azure"
  default     = "stringls"
}

variable "sql_admin_password" {
  type        = string
  sensitive   = true
  description = "SQL Server password name in Azure"
}

variable "max_size_gb" {
  type        = number
  description = "Maximum size of the database"
  default     = 1
}

variable "sql_size" {
  type        = string
  description = "The SQL Server database size"
  default     = "Basic"
}

variable "web_app_sku_name" {
  type        = string
  description = "The App Service plan tier"
  default     = "B1"
}

variable "dotnet_version" {
  type        = string
  description = "The version of .NET SDK"
  default     = "6.0"
}

variable "sa_name" {
  type        = string
  description = "The Storage Account name"
  default     = "wpcontent"
}

variable "sa_type" {
  type        = string
  description = "Type of the storage account"
  default     = "AzureFiles"
}

variable "sa_mounth_path" {
  type        = string
  description = "The path at which to mount the storage share"
  default     = "/home/site/wwwroot/wp-content"
}

variable "repository_url" {
  type        = string
  description = "Repo url for App Service"
  default     = "https://github.com/Stringls/Chess"
}

variable "branch_pointer" {
  type        = string
  description = "Branch pointer for Repo"
  default     = "main"
}