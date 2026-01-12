variable "aim_role_eks_arn" {
    type = string
}

variable "iam_role_nodes_arn" {
  type = string
}

variable "subnet_private_id_1" {
  type = string
}

variable "subnet_private_id_2" {
  type = string
}

variable "eks_cluster_name" {
  type = string
  default = "eks-cluster-name"
}

variable "eks_node_group_name" {
  type = string
  default = "eks-node-group"
}

variable "iam_role_aws_lbc_arn" {
  type = string
}