resource "aws_ecs_cluster" "tm-devops-ecs-cluster" {
  name = var.tm_ecs_cluster_name
}

resource "aws_ecs_task_definition" "tm-devops-ecs-task" {
  family = var.tm_ecs_task_family
  execution_role_arn = var.ecs_execution_role_arn
  task_role_arn = var.ecs_task_role_arn
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu       = var.tm_ecs_task_cpu
  memory    = var.tm_ecs_task_memory


  container_definitions = jsonencode([
    {
      name      = var.tm_ecs_container_name
      image     = "nginx:${var.tm_ecs_nginx_version}"
      essential = true
      mountPoints = [
        {
          sourceVolume  = "nginx-storage"
          containerPath = "/usr/share/nginx/html"
          readOnly      = false
        }
      ]
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])

  volume {
    name      = "nginx-storage"

    efs_volume_configuration {
      file_system_id          = var.tm_efs_id
      root_directory          = "/"
      transit_encryption      = "ENABLED"
  }
  }
}

resource "aws_ecs_service" "tm-devops-ecs-service" {
  name            = var.tm_ecs_service_name
  cluster         = aws_ecs_cluster.tm-devops-ecs-cluster.id
  task_definition = aws_ecs_task_definition.tm-devops-ecs-task.arn
  desired_count   = var.tm_ecs_service_count
  depends_on      = [var.ecs_execution_role_attachment]
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [var.tm_subnet_private_id]
    security_groups = [var.tm_ecs_security_group_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = var.tm_ecs_container_name
    container_port   = 80
  }
}