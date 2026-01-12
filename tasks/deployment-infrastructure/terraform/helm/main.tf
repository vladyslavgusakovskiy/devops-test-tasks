resource "helm_release" "aws_lbc" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  namespace = "kube-system"
  chart      = "aws-load-balancer-controller"
  version    = "1.7.2"

  set {
    name  = "vpcId"
    value = var.vpc_id 
  }

  set {
    name  = "replicaCount"
    value = "1"
  }

  set {
    name  = "enableWebhook" 
    value = "false"
  }

  set {
    name  = "clusterName"
    value = var.eks_cluster_name
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
    name  = "serviceAccount.create"
    value = "true" 
  }
}