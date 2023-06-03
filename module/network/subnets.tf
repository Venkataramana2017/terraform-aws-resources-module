resource "aws_subnet" "subnet_public" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.core_vpc.id
  cidr_block        = element(var.public, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = merge(
    tomap({Name           = "${var.environment}-${var.sub_services_names["public${count.index}"]}", 
    VPC                 = aws_vpc.core_vpc.tags.Name}),
    var.common_tags,
    #map("Classification", "public")
  )
}

resource "aws_subnet" "subnet_private_app" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.core_vpc.id
  cidr_block        = element(var.private_app, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = merge( 
    tomap({Name        =  "${var.environment}-${var.sub_services_names["private_app${count.index}"]}", 
            VPC        =  aws_vpc.core_vpc.tags.Name}),
    var.common_tags,
    #map("Classification", "private")
  )
}

resource "aws_subnet" "subnet_private_db" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.core_vpc.id
  cidr_block        = element(var.private_db, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = merge( 
    tomap({Name       ="${var.environment}-${var.sub_services_names["private_db${count.index}"]}",
           VPC        = aws_vpc.core_vpc.tags.Name}),
    var.common_tags,
    #map("Classification", "private")
  )
}