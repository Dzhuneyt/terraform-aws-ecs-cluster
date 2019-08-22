# Terraform module for AWS ECS clusters
 Terraform module for creating an AWS ECS cluster of EC2 instances (spot & on-demand) and an optional VPC
 
 
## Usage
```hcl-terraform
module "ecs-cluster" {
  source = "git::git@github.com:Dzhuneyt/Terraform-Module-AWS-ECS-Cluster.git"

  # The module will create a brand new VPC to house its EC2 instances
  create_vpc = true

  # Alternatively, pass an existing VPC + subnets
  vpc_id = var.vpc_id
  subnet_ids = var.public_subnets
}
```

See the /examples directory for more scenarios.
