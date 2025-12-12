output "tm_vm_security_group_id" {
    description = "The ID of the VM security group"
    value = aws_security_group.tm_vm_sg.id
}

output "tm_efs_security_group_id" {
    description = "The ID of the EFS security group"
    value = aws_security_group.tm_efs_security_group.id
}

output "tm_ecs_security_group_id" {
    description = "The ID of the ECS security group"
    value = aws_security_group.tm_ecs_security_group.id
}

output "tm_ald_security_group_id" {
    description = "The ID of the ALB (public) security group"
    value       = aws_security_group.tm_ald_security_group.id
}