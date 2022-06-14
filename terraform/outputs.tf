# here you can specify what you want to get after a successful deployment

output "webapp_url" {
  value = azurerm_linux_web_app.webapp.name
}