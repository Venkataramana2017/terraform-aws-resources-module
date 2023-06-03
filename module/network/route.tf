#Below is the Resource to Create RouteTable and Route Entries

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.core_vpc.id
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.core_igw.id
  }

  tags = merge(
      tomap({Name             = "${var.environment}-rtb-public-all",
             VPC              = "aws_vpc.core_vpc.tags.Name"}),
     var.common_tags
      )
}

resource "aws_route_table" "private_app" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.core_vpc.id
  
 route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.core_nat.*.id[0]
  } 

  tags = merge(
    tomap({Name          = "var.environment-rtb-private-az${count.index + 1}",
            VPC          =  aws_vpc.core_vpc.tags.Name}),
    var.common_tags,
   
  )
}

resource "aws_route_table" "private_data" {
 # count    = length(var.availability_zones)
  vpc_id = aws_vpc.core_vpc.id
  
 
 /*{
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.core_nat.*.id, count.index)
  } */

  tags = merge(
    tomap({Name      = "${var.environment}-rtb-private_data-all",
    VPC              =  aws_vpc.core_vpc.tags.Name}),
    var.common_tags,
   #map("Classification", "private")
    #Classification   =  private ,
      )
}
resource "aws_route_table_association" "public" {
  count          = length(var.availability_zones)
  subnet_id      = element(aws_subnet.subnet_public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_app" {
  count          = length(var.availability_zones)
  subnet_id      =  element(aws_subnet.subnet_private_app.*.id, count.index)
  route_table_id =  aws_route_table.private_app.*.id[count.index]
}

resource "aws_route_table_association" "private_data" {
  count        =  length(var.availability_zones)
  subnet_id    = element(aws_subnet.subnet_private_db.*.id, count.index)
  route_table_id = aws_route_table.private_data.id
}