

resource "aws_launch_configuration" "ecs_config_launch_config_spot" {
  name_prefix                 = "${var.cluster_name}_ecs_cluster_spot"
  image_id                    = data.aws_ami.aws_optimized_ecs.id

  instance_type               =  var.instance_type_spot
  spot_price                  = var.spot_bid_price
  associate_public_ip_address = true
  lifecycle {
    create_before_destroy = true
  }
  user_data = <<EOF
  #!/bin/bash
  echo ECS_CLUSTER=${var.cluster_name} >> /etc/ecs/ecs.config
  EOF

  security_groups = [module.ec2_sg.security_group_id]

  key_name             = "xxxxx"
  iam_instance_profile = aws_iam_instance_profile.ecs_agent.arn
}

variable "instance_type_spot" {
  default = "t3.medium"
  type    = string
}

variable "spot_bid_price" {
  default     = "0.0175"
  description = "How much you are willing to pay as an hourly rate for an EC2 instance, in USD"
}

variable "cluster_name" {
  default     = "ecs_terraform_ec2"
  type        = string
  description = "the name of an ECS cluster"
}
