resource "aws_efs_file_system" "tm-devops-efs" {
  creation_token   = var.tm_efs_name
  performance_mode = "generalPurpose"
  encrypted        = true

  tags = {
    Name = var.tm_efs_name
  }
}

resource "aws_efs_mount_target" "tm-devops-efs-mount-target" {
  file_system_id  = aws_efs_file_system.tm-devops-efs.id
  security_groups = [var.tm_efs_sg_id]
  subnet_id       = var.tm_subnet_private_id
}