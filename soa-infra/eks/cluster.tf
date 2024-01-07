resource "aws_eks_cluster" "eks-cluster" {
  name     = "UMS-eks"
  role_arn = aws_iam_role.EKSClusterRole.arn


  #version = "1.23"

  vpc_config {
    subnet_ids = var.private_subnets_id
    security_group_ids = [aws_security_group.eks-cluster-sg.id]
    endpoint_public_access  = true
    #endpoint_private_access = true
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy
  ]
}
