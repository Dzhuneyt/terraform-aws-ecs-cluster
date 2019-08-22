# Terraform module for AWS ECS clusters
 Terraform module for creating an AWS ECS cluster of EC2 instances (spot & on-demand) and an optional VPC
 
 
## Usage
```hcl-terraform
module "ecs-cluster" {
  source = "git::git@github.com:Dzhuneyt/Terraform-Module-AWS-ECS-Cluster.git"
  create_vpc = true
}
```

See the /examples directory for more scenarios.
