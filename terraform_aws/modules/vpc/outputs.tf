output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_1_id" {
  value = aws_subnet.main-private-1.id
}

output "subnet_2_id" {
  value = aws_subnet.main-private-2.id
}

output "public_subnet1_id" {
  value = aws_subnet.main-public-1.id
}

output "public_subnet2_id" {
  value = aws_subnet.main-public-2.id
}