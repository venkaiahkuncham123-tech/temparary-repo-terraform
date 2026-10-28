data "aws_availability_zones" "az" {
    state = available
  
}
data "aws_ami" "ami" {
    most_recent = true
    owners = [ "amazon" ]
    filter {
      name = "root-device-type"
      values = ["ebs"]
    }
    filter {
      name = "virtualization-type"
      values = [ "hvm" ]
    }
     filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}
locals {
  common_tags ={
    Name = "Phone-Pe"
  }
}
resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = local.common_tags
    }  
}
resource "aws_internet_gateway_attachment" "igw_assoc" {
    vpc_id = aws_vpc.vpc.id
    internet_gateway_id = aws_internet_gateway.igw.id
  
}
resource "aws_subnet" "public_subnet" {
    cidr_block = var.public_subnet_cidr
    availability_zone = data.aws_availability_zones.az[0]
    vpc_id = aws_vpc.vpc.id
    map_public_ip_on_launch = true
    tags = {
        Name = local.common_tags
    }  
}
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = var.public_route
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
      Name = "${local.common_tags}-Public-rt"
    }
  
}

resource "aws_route_table_association" "public_rt_association" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_rt.id
  
}
resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_cidr
    availability_zone = data.aws_availability_zones.az[1]
    tags = {
      Name = "${local.common_tags}-Private"
    }
  
}

resource "aws_route_table" "private_route_table" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = var.private_rt_cidr
    }
    tags = {
      Name = "${local.common_tags}-private-rt"
    }
}
resource "aws_route_table_association" "private_rt_assoc" {
    subnet_id = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.private_route_table.id     
}
resource "aws_security_group" "sg" {
    vpc_id = aws_vpc.vpc.id
    ingress {
        from_port = "22"
        to_port = "22"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = "80"
        to_port = "80"
        protocol = "tcp"
        cidr_blocks = [var.private_cidr]
    }
    egress {
        from_port = "0"
        to_port = "0"
        protocol = "tcp"
        cidr_blocks = "-1"
    }
}
resource "aws_key_pair" "pair" {
    key_name = "terraform"
    public_key = file("./terraform.pub")   
  
}
resource "aws_instance" "ec2" {
    ami = data.aws_ami.ami.id
    instance_type = var.itype
    vpc_security_group_ids = [ aws_security_group.sg.id ]
    subnet_id = aws_subnet.public_subnet.id
    key_name = aws_key_pair.pair.key_name
    associate_public_ip_address = true

    tags = {
        Name = "${local.common_tags}-public-Instance"
    }    
  
}

resource "aws_instance" "private_ec2" {
    ami = data.aws_ami.ami.id
    instance_type = var.itype
    key_name = aws_key_pair.pair.key_name
    vpc_security_group_ids = [ aws_security_group.sg.id]
    subnet_id = aws_subnet.private_subnet.id
    tags = {
      Name = "${local.common_tags}-Private-Instance"
    }
  
}