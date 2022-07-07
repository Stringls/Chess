output "eb_security_group_id" {
  value = aws_security_group.eb_app_prod.id
}

output "app_name" {
  value = aws_elastic_beanstalk_application.app.name
}

output "env_app" {
  value = aws_elastic_beanstalk_environment.app-prod.name
}