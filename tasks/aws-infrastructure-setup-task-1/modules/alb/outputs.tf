output "application_lb_tg_arn" {
  description = "The ARN of the Application Load Balancer Target Group"
  value       = aws_lb_target_group.application_lb_tg.arn
}