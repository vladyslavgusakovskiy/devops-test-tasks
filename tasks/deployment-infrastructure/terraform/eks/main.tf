resource "aws_eks_cluster" "eks" {
  name = "eks-cluster-name"

  access_config {
    authentication_mode = "API"
  }

  role_arn = var.aim_role_eks_arn
  version  = "1.31"

  vpc_config {
    subnet_ids = [
      var.subnet_private_id_1,
      var.subnet_private_id_2
    ]
  }
}

resource "aws_eks_node_group" "eks" {
  cluster_name    = aws_eks_cluster.eks.name
  version  = "1.31"
  node_group_name = "eks-node-group"
  node_role_arn   = var.iam_role_nodes_arn
  subnet_ids      = [
    var.subnet_private_id_1,
    var.subnet_private_id_2
  ]

  capacity_type = "ON_DEMAND"
  instance_types = [ "t3.large" ]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    var.eks_worker_node_policy,
    var.ec2_container_registry_read_only
  ]
}