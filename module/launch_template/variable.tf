# Count variable to check condition before creating Resource
variable "lt_efs_enabled" {
  description = "Enable/Disable LC with EFS mount"
  default     = false
}

# Below are the List of vairables for launch Template

variable "core_lt_name" {
  description = "Core launch configuration name"
}

variable "core_lt_ami" {
  description = "Core launch configuration AMI"
}


variable "key_name" {
  description = "Core launch configuration AMI"
}

variable "instance_shutdown_behaviour" {
  description = "EC2 Shutdown behaviour"
}

variable "instance_detail_monitoring" {
  description = "EC2 Instance monitoring option Detail or standard"
}

variable "lt_security_group_ids" {
  description = "Launch configuration security group ids"
  type        = list
}

variable "resource_to_tag" {
  description = "Resource to attach Tag while launching Instance/Volume"
}

variable "asg_subnet_ids" {
  description = "ASG subnet ids"
  type        = list
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  default     = ""
}

variable "iam_instance_profile" {
  description = "EC2 Service Role Instance Profile"
  default     = ""
}

variable "environment_tag" {
  description = "Environment name i.e. st6"
}

variable "application_tag" {
  description = "Autoscaling group application name"
}

variable "ec2_name_tag" {
  description = "Autoscaling group ec2 name"
}

variable "brand_tag" {
  description = "Autoscaling group ec2 brand value i.e. cr"
}

variable "application_category_tag" {
  description = "Autoscaling group ec2 application category i.e. Hybris"
}

variable "project_tag" {
  description = "Autoscaling group ec2 project value i.e. bau"
}

####### Autoscaling Group Variables ######
variable "asg_name" {
  description = "Autoscaling group name"
}

variable "asg_min_size" {
  description = "Minimum number of instances"
}

variable "asg_max_size" {
  description = "Maximum number of instances"
}

variable "desired_capacity" {
  description = "Autoscaling group ec2 tier i.e. webstack"
}

variable "health_check_type" {
  description = "Autoscaling group health check type"
}

variable "health_check_grace_period" {
  description = "Autoscaling group health check grace period"
}

variable "default_cooldown" {
  description = "Time in seconds after scaling activity completes before another can start"
}

variable "termination_policies" {
  description = "List of policies to decide how the instances in ASG should be terminated"
  type        = list
}

variable "enabled_metrics" {
  description = "List of metrics to collect"
  type        = list
}

variable "suspended_processes" {
  description = "List of processes to enable/disable during autoscaling"
  type        = list
}

variable "tg_arns" {
  description = "ALB target group ARNs"
  type        = list
  default     = [""]
}

variable "asg_service_linked_role_arn" {
  description = "Service linked role to attach to ASG"
  default     = ""
}

variable "on_demand_allocation_strategy" {
  description = "On-demand instance allocation strategy"
  default     = ""
}

variable "on_demand_base_capacity" {
  description = "On-demand Base capacity to maintain"
  default     = ""
}

variable "on_demand_percentage_above_base_capacity" {
  description = "On-demand above Base capacity to maintain"
  default     = ""
}

variable "spot_allocation_strategy" {
  description = "Spot Instance allocation startegy"
  default     = ""
}
###Capacity Optimmized enabling######
#variable "spot_instance_pools" {
#  description = "Spot Instance pools to create and maintain"
#  default     = ""
#}

variable "spot_max_price" {
  description = "Spot Instance maximum bidding price"
  default     = ""
}

variable "launch_template_version" {
  description = "Launch Template version to configure"
  default     = ""
}

variable "spot_instance_type1" {
  description = "Instance Type as per Best practice to avoid service intruption in Spot Instance"
  default     = ""
}

variable "spot_instance_type2" {
  description = "Instance Type as per Best practice to avoid service intruption in Spot Instance"
  default     = ""
}

variable "spot_instance_type3" {
  description = "Instance Type as per Best practice to avoid service intruption in Spot Instance"
  default     = ""
}


# variable "efs_mt_ip_az1" {
#   description = "EFS mount point IP AZ1"
#   default     = ""
# }
#
# variable "efs_mt_ip_az2" {
#   description = "EFS mount point IP AZ2"
#   default     = ""
# }

variable "efs_mount_targets_ips" {
  description = "EFS mount points IPs"
  type        = list
  default     = [""]
}

variable "efs_mount_tgts" {
  description = "EFS mount target names"
  default     = ""
}

variable "atc_nfs_mount_tgt" {
  description = "AtcomCache NFS mount target"
  default     = ""
}

variable "atc_nfs_mount_src" {
  description = "AtcomCache NFS mount source"
  default     = ""
}