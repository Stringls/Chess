terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.9.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

################################################
# random string for web app and database server
################################################

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

locals {
  project_name = lower(var.project_name)
}

########################
# storage
########################

resource "azurerm_storage_account" "sa" {
  name                     = "${local.project_name}storage${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "prod"
  }
}

resource "azurerm_storage_share" "sashare" {
  name                 = "${local.project_name}-sashare-${random_string.suffix.result}"
  storage_account_name = azurerm_storage_account.sa.name
  quota                = 50
}

#############################
# mssql database and server
#############################

resource "azurerm_mssql_server" "sqldb" {
  name                         = "${local.project_name}-sql-${random_string.suffix.result}"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_login
  administrator_login_password = var.sql_admin_password
}

resource "azurerm_mssql_database" "db" {
  name        = var.sql_database_name
  server_id   = azurerm_mssql_server.sqldb.id
  collation   = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb = var.max_size_gb
  sku_name    = var.sql_size
}

resource "azurerm_mssql_firewall_rule" "allow_all_azure_ips" {
  name             = "AllowAllWindowsAzureIps"
  server_id        = azurerm_mssql_server.sqldb.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

resource "azurerm_mssql_database_extended_auditing_policy" "db_policy" {
  database_id                             = azurerm_mssql_database.db.id
  storage_endpoint                        = azurerm_storage_account.sa.primary_blob_endpoint
  storage_account_access_key              = azurerm_storage_account.sa.primary_access_key
  storage_account_access_key_is_secondary = false
  retention_in_days                       = 6
}

########################
# linux web app
########################

resource "azurerm_service_plan" "app_plan" {
  name                = "${local.project_name}-app-service-plan-${random_string.suffix.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = var.web_app_sku_name
}

resource "azurerm_linux_web_app" "webapp" {
  name                = "${local.project_name}-web-app-${random_string.suffix.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.app_plan.id

  site_config {
    always_on        = false
    app_command_line = "dotnet Chess.Web.dll"

    application_stack {
      dotnet_version = var.dotnet_version
    }
  }

  app_settings = {
    "ASPNETCORE_ENVIRONMENT" = "Development"
  }

  connection_string {
    name  = "ChessDb"
    type  = "SQLServer"
    value = "Server=tcp:${azurerm_mssql_server.sqldb.fully_qualified_domain_name},1433;Database=${azurerm_mssql_database.db.name};User ID=${azurerm_mssql_server.sqldb.administrator_login};Password='${azurerm_mssql_server.sqldb.administrator_login_password}';Trusted_Connection=False;Encrypt=True;"
  }

  storage_account {
    name         = var.sa_name # wpcontent
    type         = var.sa_type # AzureFiles
    account_name = azurerm_storage_account.sa.name
    access_key   = azurerm_storage_account.sa.primary_access_key
    share_name   = azurerm_storage_share.sashare.name
    mount_path   = var.sa_mounth_path # /home/site/wwwroot/wp-content
  }
}

####################################
# source control for linux web app
####################################

resource "azurerm_app_service_source_control" "scm" {
  app_id   = azurerm_linux_web_app.webapp.id
  repo_url = var.repository_url
  branch   = var.branch_pointer
}