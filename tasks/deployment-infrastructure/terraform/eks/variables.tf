variable "aim_role_eks_arn" {
    type = string
}

variable "iam_role_nodes_arn" {
  type = string
}

variable "subnet_private_id_1" {
  type = number
}

variable "subnet_private_id_2" {
  type = number
}

variable "eks_worker_node_policy" {
  type = string
}

variable "ec2_container_registry_read_only" {
  type = string
}