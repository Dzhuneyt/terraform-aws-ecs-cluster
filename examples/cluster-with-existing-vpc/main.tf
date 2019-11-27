module "ecs-cluster-with-new-vpc" {
  source = "../../"

  cluster_name = "with-existing-vpc"

  # Reuse an existing or externally created VPC
  create_vpc = false

  # EC2 instances will live within this VPC
  vpc_id = module.vpc.vpc_id

  # Launch EC2 instances within these subnets
  subnet_ids = module.vpc.public_subnets
}
