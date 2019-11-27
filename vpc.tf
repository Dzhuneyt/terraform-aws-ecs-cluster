# TODO create a new VPC if the variable vpc_id is empty

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~>2.20"

  name = "VPC of cluster ${var.cluster_name}"
  cidr = "10.0.0.0/16"

  azs = [
    data.aws_availability_zones.available.names[0],
    data.aws_availability_zones.available.names[1],
    data.aws_availability_zones.available.names[2]
  ]
  private_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24",
  "10.0.3.0/24"]
  public_subnets = [
    "10.0.101.0/24",
    "10.0.102.0/24",
  "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false
  single_nat_gateway = true
  create_vpc         = var.create_vpc
  enable_efs_endpoint = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = var.cluster_name
  }
}
locals {
  public_subnet_ids = var.create_vpc ? module.vpc.public_subnets : var.subnet_ids
}
