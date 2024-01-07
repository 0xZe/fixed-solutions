resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "node_group"
  node_role_arn   = aws_iam_role.NodeGroupRole.arn
  subnet_ids      = var.private_subnets_id

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }

  remote_access {
    ec2_ssh_key = "key"
  }

  instance_types = ["c4.xlarge"]
  capacity_type  = "ON_DEMAND"

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy
  ]
}
