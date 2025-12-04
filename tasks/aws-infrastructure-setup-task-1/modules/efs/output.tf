output "efs_id" {
  description = "The ID of the EFS file system"
  value       = aws_efs_file_system.tm-efs.id
}

output "efs_arn" {
  description = "The ARN of the EFS file system"
  value       = aws_efs_file_system.tm-efs.arn
}