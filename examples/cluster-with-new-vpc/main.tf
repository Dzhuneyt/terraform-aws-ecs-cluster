module "ecs-cluster-with-new-vpc" {
  source = "github.com/Dzhuneyt/terraform-module-aws-ecs-cluster?ref=v1.0.5"

  cluster_name = "with-new-vpc"

  # The module will create a new VPC and subnets
  # and start launching EC2 instances
  # within that VPC's public subnets
  create_vpc = true
}
