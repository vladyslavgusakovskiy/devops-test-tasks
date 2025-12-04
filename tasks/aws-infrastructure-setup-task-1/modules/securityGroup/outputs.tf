output "tm_efs_security_group_id" {
    description = "The ID of the EFS security group"
    value = aws_security_group.tm_efs_security_group.id
}