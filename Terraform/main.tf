data "aws_ami" "ami" {
 most_recent = true
 owners= [ "amazon" ] 
filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  

}
resource "aws_instance" "ec2" {
  ami                    = "ami-0d97d7f07b25dd693"

	instance_type          = var.region == "Production" ? "t3.small" : "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = "useast"
  provider               = aws.east-1
  tags = {
    Name = "Terraform-Instance"
  }

}
resource "aws_security_group" "sg" {
  provider = aws.east-1
  vpc_id   = aws_vpc.vpc.id
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc-cidr
  provider   = aws.east-1
  tags = {
    Name = var.vpc_name
  }

}
resource "aws_internet_gateway" "igw" {
  vpc_id   = aws_vpc.vpc.id
  provider = aws.east-1
}
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_cidr
  availability_zone = var.az
  provider          = aws.east-1
  tags = {
    Name = "${var.vpc_name}-Public-Subnet"
  }
}
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_cidr_block
  availability_zone = var.private_az
  provider          = aws.east-1
  tags = {
    Name = "${var.vpc_name}-Private-Subnet"
  }

}
resource "aws_route_table" "public_route_table" {
  vpc_id   = aws_vpc.vpc.id
  provider = aws.east-1
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.vpc_name}-Public-Rt"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id   = aws_vpc.vpc.id
  provider = aws.east-1
  route {
    cidr_block = "0.0.0.0/0"
  }
  tags = {
    Name = "${var.vpc_name}-Private-Route-Table"
  }

}
resource "aws_route_table_association" "public_rt_association" {
  subnet_id      = aws_subnet.public_subnet.id
  provider       = aws.east-1
  route_table_id = aws_route_table.public_route_table.id

}

resource "aws_route_table_association" "private_rt_association" {
  provider       = aws.east-1
  subnet_id      = aws_route_table.private_route_table.id
  route_table_id = aws_route_table.private_route_table.id

}
resource "aws_network_acl" "acl" {
  vpc_id   = aws_vpc.vpc.id
  provider = aws.east-1
  ingress {
    from_port  = 8080
    to_port    = 8080
    rule_no    = 100
    protocol   = "tcp"
    cidr_block = "0.0.0.0/0"
    action     = "allow"
  }
  egress {
    from_port  = 8080
    to_port    = 8080
    protocol   = "tcp"
    rule_no    = 101
    cidr_block = "0.0.0.0/0"
    action     = "allow"
  }
}
resource "aws_network_acl_association" "nc_association" {

  subnet_id      = aws_route_table.public_route_table.id
  network_acl_id = aws_network_acl.acl.id
}
