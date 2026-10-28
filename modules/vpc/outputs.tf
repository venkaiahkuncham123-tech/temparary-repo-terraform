output "vpc_id" {
    value = aws_vpc.vpc.id
  
}
output "aws_security_group_id" {
    value = aws_security_group.sg.id
  
}
output "subnet_id" {
    value = aws_subnet.subnet.id
  
}