resource "aws_security_group" "tm_ald_security_group" {
  name        =  var.ald_sg_name
  description = "Enable http access on port 80"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.ald_sg_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "tm_ald_ingress_rule" {
  security_group_id = aws_security_group.tm_ald_security_group.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_security_group" "tm_ecs_security_group" {
  name        = var.ecs_sg_name
  description = "Enable http access on port 80 via ALB security group"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.ecs_sg_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "tm_ecs_ingress_rule" {
  security_group_id = aws_security_group.tm_ecs_security_group.id

  referenced_security_group_id = aws_security_group.tm_ald_security_group.id
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_security_group" "tm_efs_security_group" {
  name        = var.efs_sg_name
  description = "Enable inbound from ecs containers on port 2049"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.efs_sg_name  
  }
}

resource "aws_vpc_security_group_ingress_rule" "tm_efs_ingress_rule" {
  security_group_id = aws_security_group.tm_efs_security_group.id

  referenced_security_group_id = aws_security_group.tm_ecs_security_group.id
  from_port   = 2049
  ip_protocol = "tcp"
  to_port     = 2049
}