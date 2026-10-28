resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    tags = {
      Name = "Module-Vpc"
    }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = module-igw
  }
}

resource "aws_subnet" "subnet" {
    vpc_id = aws_vpc.vpc.id
    availability_zone = var.sub_az
    cidr_block = var.subnet_cidr
    map_public_ip_on_launch = true
    tags = {
      Name = "Module-Subnet"
    }
  
}
resource "aws_route_table" "rt" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = var.rt_cidr
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "Module-Rt"
    }
  
}
resource "aws_route_table_association" "rt_assoc" {
    subnet_id = aws_subnet.subnet.id
    route_table_id = aws_route_table.rt.id  
}
resource "aws_security_group" "sg" {
    vpc_id = aws_vpc.vpc.id
    ingress {
        from_port = "22"
        to_port = "22"
        protocol = "tcp"
        cidr_blocks = var.sg_cidr
    }
    egress {
        from_port = "0"
        to_port = "0"
        protocol = "tcp"
        cidr_blocks = ["-1"]
    }
  
}