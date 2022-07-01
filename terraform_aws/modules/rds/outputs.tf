output "db_instance_endpoint" {
  value = aws_db_instance.rds-app-prod.endpoint
}

output "db_instance_username" {
  value = aws_db_instance.rds-app-prod.username
}