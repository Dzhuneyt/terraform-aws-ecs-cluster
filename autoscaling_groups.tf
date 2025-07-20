# Create two autoscaling groups one for spot and the other for spot.
resource "aws_autoscaling_group" "ecs_cluster_ondemand" {
  name_prefix = "${var.cluster_name}_asg_ondemand_"
  termination_policies = [
  "OldestInstance"]
  default_cooldown          = 30
  health_check_grace_period = 30
  max_size                  = var.max_ondmand_instances
  min_size                  = var.min_ondemand_instances
  desired_capacity          = var.min_ondemand_instances
  launch_template {
    id      = aws_launch_template.ecs_launch_template_ondemand.id
    version = "$Latest"
  }
  lifecycle {
    create_before_destroy = true
  }
  vpc_zone_identifier = local.public_subnet_ids

  tag {
    key                 = "Name"
    value               = var.cluster_name
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "ecs_cluster_spot" {
  name_prefix = "${var.cluster_name}_asg_spot_"
  termination_policies = [
  "OldestInstance"]
  default_cooldown          = 30
  health_check_grace_period = 30
  max_size                  = var.max_spot_instances
  min_size                  = var.min_spot_instances
  desired_capacity          = var.min_spot_instances
  launch_template {
    id      = aws_launch_template.ecs_launch_template_spot.id
    version = "$Latest"
  }

  # Allow the ASG to be created through Terraform,
  # even if the price is too low or there are other
  # issues with placing the spot request
  wait_for_capacity_timeout = "0"
  lifecycle {
    create_before_destroy = true
  }
  vpc_zone_identifier = local.public_subnet_ids

  tag {
    key                 = "Name"
    value               = var.cluster_name
    propagate_at_launch = true
  }
}

# Attach an autoscaling policy to the spot cluster to target 70% MemoryReservation on the ECS cluster.
resource "aws_autoscaling_policy" "ecs_cluster_scale_policy" {
  name            = "${var.cluster_name}_ecs_cluster_spot_scale_policy"
  policy_type     = "TargetTrackingScaling"
  adjustment_type = "ChangeInCapacity"
  lifecycle {
    ignore_changes = [
      adjustment_type
    ]
  }
  autoscaling_group_name = aws_autoscaling_group.ecs_cluster_spot.name

  target_tracking_configuration {
    customized_metric_specification {
      metric_dimension {
        name  = "ClusterName"
        value = var.cluster_name
      }
      metric_name = "MemoryReservation"
      namespace   = "AWS/ECS"
      statistic   = "Average"
    }
    target_value = 70.0
  }
}
