variable "vpc_cidr" {
  description = "IP range of Core VPC"
}

variable "environment" {
  description = "tcbuk environment"
}

variable "public" {
  description = "Subnet list with IP ranges"
  type        = list(string)
}

variable "private_app" {
  description = "Subnet list with IP ranges"
  type        = list(string)
}

variable "private_db" {
  description = "Subnet list with IP ranges"
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability zones that are going to be used for the subnets"
  type        = list(string)
}

variable "vpc_name" {
  description = "VPC name related to the environment and the source market"
}

variable "vpc_flow_log_group_name" {
  description = "VPC flowlogs log group name"
}

variable "sub_services_names" {
  description = "List with the names of the sub-services"
  type        = map(string)
}

variable "common_tags" {
  type        = map(string)
}
