output "instace_id" {
    value = aws_ec2.ec2.id
  
}
output "vpc_id" {
    value = aws_vpc.vpc.id
  
}
output "igw_id" {
    value = aws_internet_gateway.igw.id
  
}