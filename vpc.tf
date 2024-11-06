resource "aws_vpc" "one" {
tags = {
Name = "myvpc"
}

cidr_block = "10.0.0.0/16"
instance_tenancy = "default"
enable_dns_hostnames = "true"
}

resource "aws_subnet" "two" {
vpc_id = aws_vpc.one.id
tags = {
Name = "subnet-1"
}
availability_zone = "ap-south-1a"
cidr_block = "10.0.1.0/24"
map_public_ip_on_launch = "true"
}

resource "aws_subnet" "three" {
vpc_id = aws_vpc.one.id
tags = {
Name = "subnet-2"
}
availability_zone = "ap-south-2a"
cidr_block = "10.0.2.0/24"
map_public_ip_on_launch = "true"
}

resource "aws_internet_gateway" "four" {
tags = {
Name = "myigw"
}
vpc_id = aws_vpc.one.id
}

resource "aws_route_table" "five" {
tags = {
Name = "myroute"
}
vpc_id = aws_vpc.one.id
route {
gateway_id = aws_internet_gateway.four.id
cidr_block = "0.0.0.0/0"
}
}


resource "aws_route_table_association" "six" {
subnet_id = aws_subnet.two.id
route_table_id = aws_route_table.five.id
}


resource "aws_route_table_association" "seven" {
subnet_id = aws_subnet.three.id
route_table_id = aws_route_table.five.id
}
