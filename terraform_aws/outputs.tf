output "app-name" {
  value = module.eb.app_name
}

output "env-app" {
  value = module.eb.env_app
}

output "aws-region" {
  value = "${var.aws_region}"
}