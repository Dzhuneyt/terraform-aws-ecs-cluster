# Allow AWS ECS to manage the cluster on my behalf
# This includes creating services and tasks, monitoring
# EC2 instance health, terminating instances, etc
resource "aws_iam_service_linked_role" "ecs" {
  custom_suffix    = var.cluster_name
  aws_service_name = "ecs.amazonaws.com"

  # The service role is automatically created by AWS the first time you create
  # an ECS cluster (no matter if you did it from the CLI, the web console or through Terraform)
  # If you attempt to create the service linked role twice, AWS returns an error
  # so this creation here is parameterized, giving you the option to
  # create or not create the service-linked role, based on if you previously created
  # an ECS cluster on your account or not
  count = var.create_iam_service_linked_role == "true" ? 1 : 0
}
