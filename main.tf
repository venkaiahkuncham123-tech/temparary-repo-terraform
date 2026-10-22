data "aws_ami" "ami" {
    most_recent = true
    owners = ["amazon"]
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
}
resource "aws_instance" "ec2" {
    ami = data.aws_ami.ami.id
    instance_type = var.itype
}
resource "aws_instance" "ec2-north" {
    ami = data.aws_ami.ami.id
    instance_type = var.itype-north
    provider = aws.north
}

resource "aws_s3_bucket" "s3-name" {
    bucket = var.s3-name
    tags = {
        Name = "s3-bucket"
        Environment = "production"
    }
}