# Modern launch templates to replace deprecated launch configurations
resource "aws_launch_template" "ecs_launch_template_spot" {
  name_prefix   = "${var.cluster_name}-ecs-spot-"
  image_id      = data.aws_ami.ecs.id
  instance_type = var.instance_type_spot
  key_name      = var.ssh_key_name

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_iam_instance_profile.name
  }

  instance_market_options {
    market_type = "spot"
    spot_options {
      max_price = var.spot_bid_price
    }
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.sg_for_ec2_instances.id]
    delete_on_termination       = true
  }

  user_data = base64encode(<<-EOF
#!/bin/bash
echo ECS_CLUSTER=${var.cluster_name} >> /etc/ecs/ecs.config
echo ECS_INSTANCE_ATTRIBUTES={\"purchase-option\":\"spot\"} >> /etc/ecs/ecs.config
EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.cluster_name}-spot"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_template" "ecs_launch_template_ondemand" {
  name_prefix   = "${var.cluster_name}-ecs-ondemand-"
  image_id      = data.aws_ami.ecs.id
  instance_type = var.instance_type_ondemand
  key_name      = var.ssh_key_name

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_iam_instance_profile.name
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.sg_for_ec2_instances.id]
    delete_on_termination       = true
  }

  user_data = base64encode(<<-EOF
#!/bin/bash
echo ECS_CLUSTER=${var.cluster_name} >> /etc/ecs/ecs.config
echo ECS_INSTANCE_ATTRIBUTES={\"purchase-option\":\"ondemand\"} >> /etc/ecs/ecs.config
EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.cluster_name}-ondemand"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
