data "aws_ami" "ami" {
     filter {
        name = "owner_alias"
        values = ["amazon"]
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