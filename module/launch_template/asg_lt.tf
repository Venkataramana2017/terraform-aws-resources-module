#Below is the resource to create Launch Template with Userdata and EFS mount

resource "aws_launch_template" "core_launch_template_efs" {
  name_prefix                         = var.core_lt_name
  image_id                            = var.core_lt_ami
  ebs_optimized                       = var.ebs_optimized
  key_name                            = var.key_name
  user_data                           = base64encode(data.template_file.asg_efs_userdata.rendered)
  instance_initiated_shutdown_behavior = var.instance_shutdown_behaviour
  iam_instance_profile {
      arn = var.iam_instance_profile
  }
  monitoring {
    enabled = var.instance_detail_monitoring
  }
  vpc_security_group_ids  = var.lt_security_group_ids
  tag_specifications {
    resource_type = var.resource_to_tag
    tags ={
          Name         = var.ec2_name_tag
          Environment  = var.environment_tag
          Application  = var.application_tag
          ApplicationCategory = var.application_category_tag
          Brand               = var.brand_tag
          Project             = var.project_tag
        }
        }
  tags = {
    Environment          = var.environment_tag
    Application          = var.application_tag
    ApplicationCategory = var.application_category_tag
    Brand               = var.brand_tag
    Project             = var.project_tag
  }
  lifecycle {
    create_before_destroy = true
  }
}

### AutoScaling Group With SPOT Option with Userdata to Attach EFS

resource "aws_autoscaling_group" "core_autoscaling_efs" {
  name                      = var.asg_name
  min_size                  = var.asg_min_size
  max_size                  = var.asg_max_size
  force_delete              = true
  desired_capacity          = var.desired_capacity
  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period
  default_cooldown          = var.default_cooldown
  termination_policies      = var.termination_policies
  enabled_metrics           = var.enabled_metrics
  target_group_arns         = var.tg_arns
  vpc_zone_identifier       = var.asg_subnet_ids
  suspended_processes       = var.suspended_processes
  service_linked_role_arn   = var.asg_service_linked_role_arn
  mixed_instances_policy {
    instances_distribution {
          on_demand_allocation_strategy            = var.on_demand_allocation_strategy
          on_demand_base_capacity                  = var.on_demand_base_capacity
          on_demand_percentage_above_base_capacity = var.on_demand_percentage_above_base_capacity
          spot_allocation_strategy                 = var.spot_allocation_strategy
          #spot_instance_pools                     = var.spot_instance_pools
          spot_max_price                           = var.spot_max_price
          }
    launch_template {
      launch_template_specification {
        launch_template_id           = aws_launch_template.core_launch_template_efs.id
        version                      = var.launch_template_version
      }
      override {
        instance_type = var.spot_instance_type1
      }
      override {
        instance_type = var.spot_instance_type2
      }
      override {
        instance_type = var.spot_instance_type3
      }
      
     }
        }

  tags = concat([
    {
      "key"                 = "Name"
      "value"               = var.ec2_name_tag
      "propagate_at_launch" = true
    },
    {
      "key"                 = "Environment"
      "value"               = var.environment_tag
      "propagate_at_launch" = true
    },
    {
      "key"                 = "Application"
      "value"               = var.application_tag
      "propagate_at_launch" = true
    },
    {
      "key"                 = "ApplicationCategory"
      "value"               = var.application_category_tag
      "propagate_at_launch" = true
    },
    {
      "key"                 = "Brand"
      "value"               = var.brand_tag
      "propagate_at_launch" = true
    },
    {
      "key"                 = "Project"
      "value"               = var.project_tag
      "propagate_at_launch" = true
    },
  ])

  lifecycle {
    create_before_destroy = true
  }
}
