# AWS Elastic Kubernetes Service (EKS)

This section contains knowledge relating to AWS Elastic Kubernetes Service (EKS).

## Adding EKS Host Nodes

To add EKS host nodes, you need to create a new node group, or add additional nodes to an existing group.  This is done via the AWS console, or via the AWS CLI.

### AWS Console

#### Adding a New Node Group

1. Sign into the AWs console.
2. Navigate to Elastic Kubernetes Service (**EKS**).
3. Locate and select the **cluster** you want to add nodes to.
4. Choose the **Configuration** tab.
5. Choose the **Compute** tab.
6. Click the **Add Node Group** button.
7. Follow the guided deployment prompts to define:
   1. Node Group Name
   2. IAM role
      1. Recommended: Copy from the existing node group if you are unsure.
   3. Launch Template
      1. Recommended: Copy from the existing node group if you are unsure.
   4. Kubernetes Labels (optional)
   5. Kubernetes Taints (optional)
      1. If building a node group for a specific purpose, you can use taints to ensure that pods are only scheduled on the nodes in that group.
      2. See [Taints and Tolerations](../Kubernetes/Kubernetes-Taints-And-Tolerations.md) for more information.
   6. Tags (optional)
8. Click the **Next** button.
9. Configure Node Group Compute
   1. AMI Type
   2. Capacity Type
   3. Instance Types
   4. Disk Size
   5. Scaling Parameters
      1. Minimum number of nodes
      2. Maximum number of nodes
      3. Desired number of nodes
   6. Maximum unavailable nodes
10. Click the **Next** button.
11. Configure connected subnet(s)
12. Click the **Next** button.
13. Review the configuration
    1.  Confirm all the settings are correct.
14. Click the **Create** button.
    1.  Wait for the node group to be created.
