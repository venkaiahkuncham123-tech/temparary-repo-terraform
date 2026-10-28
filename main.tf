module "ec2" {
    vpc_cidr = "192.100.0.0/16"
    sub_az = "eu-north-1a"
    subnet_cidr = "192.100.1.0/24"
    rt_cidr = "0.0.0.0/0"
    sg_cidr = "0.0.0.0/0"
    source = "git::https://github.com/venkaiahkuncham123-tech/temparary-repo-terraform.git"
}
resource "aws_instance" "ec2" {
    ami = var.ami
    instance_type = "t3.small"
    vpc_security_group_ids = [module.ec2.aws_security_group_id]
    subnet_id = module.ec2.subnet_id
    key_name = "ubuntu"
    associate_public_ip_address = true
    tags = {
        Name = "Module-EC2"
    }
}