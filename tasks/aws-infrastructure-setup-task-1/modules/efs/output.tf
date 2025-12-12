output "efs_id" {
  description = "The ID of the EFS file system"
  value       = aws_efs_file_system.tm-efs.id
}

output "efs_arn" {
  description = "The ARN of the EFS file system"
  value       = aws_efs_file_system.tm-efs.arn
}

output "efs_mount_target_id" {
  description = "The ID of the EFS mount target"
  value       = aws_efs_mount_target.tm-efs-mount-target.id
}

output "efs_mount_target_ip_address" {
  description = "The IP address of the EFS mount target"
  value       = aws_efs_mount_target.tm-efs-mount-target.ip_address
}