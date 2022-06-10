output "webapp_url" {
    value = azurerm_linux_web_app.webapp.default_hostname
}

output "webapp_ips" {
    value = azurerm_linux_web_app.webapp.outbound_ip_addresses
}

output "sql_server_id" {
    value = azurerm_mssql_server.sqldb.id
}