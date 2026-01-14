data "aws_eks_cluster" "eks_cluster" {
  name = var.eks_cluster_name
}

resource "aws_security_group" "database_sg" {
  name        = "database_security_group"
  description = "Enable Postgres access on port 5432"
  vpc_id      = var.vpc_id
  tags = {
    Name = "database_security_group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.database_sg.id
  referenced_security_group_id = data.aws_eks_cluster.eks_cluster.vpc_config[0].cluster_security_group_id
  from_port         = 5432
  ip_protocol       = "tcp"
  to_port           = 5432
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.database_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db_subnet_group"
  subnet_ids = [var.subnet_private_id_1, var.subnet_private_id_2]

  tags = {
    Name = "db_subnet_group"
  }
}

resource "aws_db_instance" "db_instance" {
  allocated_storage    = 200
  db_name              = "postgresdb"
  engine               = "postgres"
  engine_version       = "18"
  multi_az             = false
  identifier           = "dev-rds-instance"
  instance_class       = "db.t3.micro"
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.database_sg.id]
  username             = "devuser"
  password             = "devuser1234"
  parameter_group_name = "default.postgres18"
  skip_final_snapshot  = true
}