module "ecs-cluster-with-new-vpc" {
  source = "github.com/Dzhuneyt/Terraform-Module-AWS-ECS-Cluster?ref=v1.0.0"

  cluster_name = "with-new-vpc"

  # The module will create a new VPC and subnets
  # and start launching EC2 instances
  # within that VPC's public subnets
  create_vpc = true
}
