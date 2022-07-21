output "eb_service_role" {
  value = var.iam_eb_role
}

output "ec2_role" {
  value = var.iam_intance_profile
}

output "ec2_instance_arn" {
  value = aws_iam_instance_profile.ec2-profile.arn
}