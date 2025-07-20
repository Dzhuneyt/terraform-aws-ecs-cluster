> **⚠️ ARCHIVED: This repository is no longer maintained.**
>
> As of July 2025, this module has been fully modernized to work with the latest versions of Terraform and AWS providers. However, it is **not recommended** to use this module for new projects.
>
> There is now an official ECS module available in the Terraform Registry, which is better maintained and more feature-rich:
> [terraform-aws-modules/terraform-aws-ecs](https://github.com/terraform-aws-modules/terraform-aws-ecs)
>
> **Please use the official module above for all new work.**


# Terraform module for creating AWS ECS clusters
 Terraform module for creating an AWS ECS cluster of EC2 instances (spot & on-demand) and an optional VPC (or reuse an existing VPC)

## Usage

The module will create a brand new VPC to house its EC2 instances:
```hcl-terraform
module "ecs-cluster" {
  source = "github.com/Dzhuneyt/terraform-module-aws-ecs-cluster?ref=v2.0.0"

  create_vpc = true
}
```

The module attaches EC2 instances to an existing VPC + subnets:
```hcl-terraform
module "ecs-cluster" {
  source = "github.com/Dzhuneyt/terraform-module-aws-ecs-cluster?ref=v2.0.0"

  create_vpc = false
  vpc_id = var.vpc_id
  subnet_ids = var.public_subnets
}
```

See the /examples directory for more scenarios.

## Authors

- [![Dzhuneyt](https://github.com/Dzhuneyt.png?size=20)](https://dzhuneyt.com) Dzhuneyt Ahmed
