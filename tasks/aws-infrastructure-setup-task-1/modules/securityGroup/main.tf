resource "aws_security_group" "tm_ald_security_group" {
  name        = var.ald_sg_name
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

resource "aws_vpc_security_group_egress_rule" "tm_ald_egress_all" {
  security_group_id = aws_security_group.tm_ald_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_security_group" "tm_ecs_security_group" {
  name        = var.ecs_sg_name
  description = "Enable http access on port 80 via ALB security group"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.ecs_sg_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "tm_ecs_ingress_alb" {
  security_group_id            = aws_security_group.tm_ecs_security_group.id
  referenced_security_group_id = aws_security_group.tm_ald_security_group.id
  from_port                    = 80
  ip_protocol                  = "tcp"
  to_port                      = 80
}

resource "aws_vpc_security_group_egress_rule" "tm_ecs_egress_internet" {
  security_group_id = aws_security_group.tm_ecs_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "tm_ecs_egress_efs" {
  security_group_id            = aws_security_group.tm_ecs_security_group.id
  referenced_security_group_id = aws_security_group.tm_efs_security_group.id
  from_port                    = 2049
  ip_protocol                  = "tcp"
  to_port                      = 2049
}


resource "aws_security_group" "tm_efs_security_group" {
  name        = var.efs_sg_name
  description = "Enable inbound from ecs containers on port 2049"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.efs_sg_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "tm_efs_ingress_ecs" {
  security_group_id            = aws_security_group.tm_efs_security_group.id
  referenced_security_group_id = aws_security_group.tm_ecs_security_group.id
  from_port                    = 2049
  ip_protocol                  = "tcp"
  to_port                      = 2049
}

resource "aws_vpc_security_group_ingress_rule" "tm_efs_ingress_vm" {
  security_group_id            = aws_security_group.tm_efs_security_group.id
  referenced_security_group_id = aws_security_group.tm_vm_sg.id
  from_port                    = 2049
  ip_protocol                  = "tcp"
  to_port                      = 2049
}

resource "aws_security_group" "tm_vm_sg" {
  name   = "vm-sg"
  vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "tm_vm_sg_ssh" {
  security_group_id = aws_security_group.tm_vm_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 22
  to_port = 22
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "tm_vm_egress_internet" {
  security_group_id = aws_security_group.tm_vm_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "tm_vm_egress_efs" {
  security_group_id            = aws_security_group.tm_vm_sg.id
  referenced_security_group_id = aws_security_group.tm_efs_security_group.id
  from_port                    = 2049
  ip_protocol                  = "tcp"
  to_port                      = 2049
}