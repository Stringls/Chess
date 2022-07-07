output "db_instance_address" {
  value = aws_db_instance.rds-app-prod.address
}

output "db_instance_username" {
  value = aws_db_instance.rds-app-prod.username
}