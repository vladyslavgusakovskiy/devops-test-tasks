resource "aws_eks_cluster" "eks" {
  name = var.eks_cluster_name

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
  node_group_name = var.eks_node_group_name
  node_role_arn   = var.iam_role_nodes_arn
  subnet_ids      = [
    var.subnet_private_id_1,
    var.subnet_private_id_2
  ]

  capacity_type = "ON_DEMAND"
  instance_types = [ "t3.small" ]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }
}

resource "aws_eks_addon" "pod_identity" {
  cluster_name = aws_eks_cluster.eks.name
  addon_name   = "eks-pod-identity-agent"
}

resource "aws_eks_pod_identity_association" "aws_lbc" {
  cluster_name = var.eks_cluster_name
  namespace = "kube-system"
  service_account = "aws-load-balancer-controller"
  role_arn = var.iam_role_aws_lbc_arn

   depends_on = [
    aws_eks_addon.pod_identity,
    aws_eks_node_group.eks
  ]
}
