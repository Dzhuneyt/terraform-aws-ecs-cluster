module "ecs-cluster-with-new-vpc" {
  source = "../../"

  cluster_name = "with-new-vpc"

  # The module will create a new VPC and subnets
  # and start launching EC2 instances
  # within that VPC's public subnets
  create_vpc = true
}
