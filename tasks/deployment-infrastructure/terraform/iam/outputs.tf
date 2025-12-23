output "aim_role_eks_arn" {
  value = aws_iam_role.eks.arn
}

output "iam_role_nodes_arn" {
  value = aws_iam_role.nodes.arn
}

output "eks_worker_node_policy" {
  value = aws_iam_role_policy_attachment.nodes_AmazonEKSWorkerNodePolicy
}

output "ec2_container_registry_read_only" {
  value = aws_iam_role_policy_attachment.nodes_AmazonEC2ContainerRegistryReadOnly
}