resource "aws_s3_bucket" "storage" {
  bucket = "my-unique-bucket-name-deployment-infrastructure"

  tags = {
    Name        = "My bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.storage.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_iam_policy" "s3_access_policy" {
  name        = "S3AppAccessPolicy"
  description = "Allow the app work with the bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
        Effect   = "Allow"

        Resource = [
          "${aws_s3_bucket.storage.arn}",
          "${aws_s3_bucket.storage.arn}/*"
        ]
      }
    ]
  })
}

data "aws_eks_cluster" "eks" {
  name = var.eks_cluster_name
}

locals {
  oidc_id = replace(data.aws_eks_cluster.eks.identity[0].oidc[0].issuer, "https://", "")
}

resource "aws_iam_role" "eks_s3_role" {
  name = "eks-s3-readonly-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Principal = {
          Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.oidc_id}"
        }
        Condition = {
          StringEquals = {
            "${local.oidc_id}:sub" = "system:serviceaccount:dev:s3-read-write-sa"
          }
        }
      }
    ]
  })
}

data "aws_caller_identity" "current" {}

resource "aws_iam_role_policy_attachment" "s3_attach" {
  role       = aws_iam_role.eks_s3_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}