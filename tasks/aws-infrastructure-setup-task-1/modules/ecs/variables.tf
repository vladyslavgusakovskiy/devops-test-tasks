variable "tm_efs_id" {
    description = "The ID of the EFS file system to be used by ECS tasks"
    type        = string
}

variable "tm_subnet_private_id" {
    description = "The ID of the private subnet to be used by ECS tasks"
    type        = string
}

variable "tm_ecs_security_group_id" {
    description = "The ID of the security group to be used by ECS tasks"
    type        = string
}

variable "tm_ecs_cluster_name" {
    description = "The name of the ECS cluster"
    type        = string
    default     = "tm-devops-ecs-cluster"
}

variable "tm_ecs_task_family" {
    description = "The family name of the ECS task definition"
    type        = string
    default     = "tm-devops-ecs-task"
}

variable "tm_ecs_service_name" {
    description = "The name of the ECS service"
    type        = string
    default     = "tm-devops-ecs-service"
}

variable "tm_ecs_service_count" {
    description = "The desired number of ECS service tasks"
    type        = number
    default     = 1
}

variable "tm_ecs_container_name" {
    description = "The name of the ECS container"
    type        = string
    default     = "nginx-web-server"
}

variable "tm_ecs_nginx_version" {
    description = "The version of the nginx image to use"
    type = string
    default = "latest"
}

variable "tm_ecs_task_cpu" {
    description = "The amount of CPU to allocate to the ECS task"
    type        = number
    default = 256
}

variable "tm_ecs_task_memory" {
    description = "The amount of memory (in MiB) to allocate to the ECS task"
    type        = number
    default = 512
}

variable "ecs_execution_role_arn" {
  description = "The ARN of the ECS Execution Role"
  type        = string
}

variable "ecs_task_role_arn" {
  description = "The ARN of the ECS Task Role"
  type        = string
}

variable "ecs_execution_role_attachment" {
  description = "The ECS Execution Role Policy Attachment"
  type        = any
}

variable "alb_target_group_arn" {
  description = "The ARN of the Application Load Balancer Target Group"
  type        = string
}