module "ec2" {
    vpc_cidr = var.vpc_cidr
    sub_az = var.sub_az
    subnet_cidr = var.subnet_cidr
    rt_cidr = var.rt_cidr
    sg_cidr = var.sg_cidr
    source = "git::https://github.com/venkaiahkuncham123-tech/temparary-repo-terraform.git//modules/vpc?ref=staging"
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
