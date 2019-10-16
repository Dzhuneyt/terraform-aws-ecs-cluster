# Terraform module for creating AWS ECS clusters
 Terraform module for creating an AWS ECS cluster of EC2 instances (spot & on-demand) and an optional VPC (or reuse an existing VPC)
 
 
## Usage

The module will create a brand new VPC to house its EC2 instances:
```hcl-terraform
module "ecs-cluster" {
  source = "github.com/Dzhuneyt/Terraform-Module-AWS-ECS-Cluster?ref=v1.0.0"

  create_vpc = true
}
```

The module attaches EC2 instances to an existing VPC + subnets:
```hcl-terraform
module "ecs-cluster" {
  source = "github.com/Dzhuneyt/Terraform-Module-AWS-ECS-Cluster?ref=v1.0.0"

  create_vpc = false
  vpc_id = var.vpc_id
  subnet_ids = var.public_subnets
}
```

See the /examples directory for more scenarios.
