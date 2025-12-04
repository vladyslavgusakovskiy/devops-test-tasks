output "ecs_execution_role_arn" {
  description = "The ARN of the ECS Role"
  value       = aws_iam_role.ecs_execution_role.arn
}

output "ecs_task_role_arn" {
  description = "The ARN of the ECS Task Role"
  value       = aws_iam_role.ecs_task_role.arn
}

output "ecs_execution_role_attachment_id" {
  description = "The ECS Execution Role Policy Attachment ID"
  value       = aws_iam_role_policy_attachment.ecs_execution_role_attachment.id
}