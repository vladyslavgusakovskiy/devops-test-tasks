output "tm_subnet_private_id" {
  description = "The ID of the private subnet where the EFS mount target will be created"
  value = aws_subnet.private.id
}

output "tm_subnet_public_id" {
  description = "The ID of the public subnet where the ALB will be created"
  value = aws_subnet.public_1.id
}

output "tm_subnet_public_1_id" {
  description = "The ID of the first public subnet"
  value = aws_subnet.public_1.id
}

output "tm_subnet_public_2_id" {
  description = "The ID of the second public subnet"
  value = aws_subnet.public_2.id
}