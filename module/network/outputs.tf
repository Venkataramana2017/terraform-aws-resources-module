# Exported Output variable
output "vpc_id" {
  value = aws_vpc.core_vpc.id
}

output "dbsubnet_ids" {
  value = aws_subnet.subnet_private_db.*.id
}

output "appsubnet_ids" {
  value = aws_subnet.subnet_private_app.*.id
}

output "pubsubnet_ids" {
  value = aws_subnet.subnet_public.*.id
}


output "availability_zones" {
  value = var.availability_zones
}

output "vpc_cidr" {
  value = aws_vpc.core_vpc.cidr_block
}
