output "ec2_id" {
    value = aws_instance.ec2.id
  
}
output "vpc_id" {
    value = module.ec2.vpc_id  
}
output "sg_id_vpc" {
    value = module.ec2.sg_id
  
}