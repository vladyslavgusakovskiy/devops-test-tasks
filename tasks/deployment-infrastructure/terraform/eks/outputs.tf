output "eks_cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = aws_eks_cluster.eks.endpoint
}

output "eks_cluster_name" {
  value       = aws_eks_cluster.eks.name
}

output "eks_cluster_certificate_authority_data" {
  value       = aws_eks_cluster.eks.certificate_authority[0].data
}