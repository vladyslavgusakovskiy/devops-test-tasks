output "aim_role_eks_arn" {
  value = aws_iam_role.eks.arn
}

output "iam_role_nodes_arn" {
  value = aws_iam_role.nodes.arn
}

output "iam_role_aws_lbc_arn" {
  value = aws_iam_role.aws_lbc.arn
}