resource "aws_ecr_repository" "docker_repository" {
  name                 = "docker-storage"
  image_tag_mutability = "IMMUTABLE"

  encryption_configuration {
    encryption_type = "AES256"
  }

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "docker-storage"
  }
}

resource "aws_ecr_lifecycle_policy" "cleanup_policy" {
  repository = aws_ecr_repository.docker_repository.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire images older than 14 days"
        selection = {
          tagStatus   = "any"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = 14
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
