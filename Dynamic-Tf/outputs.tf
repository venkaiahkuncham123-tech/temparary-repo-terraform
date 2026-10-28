output "instance_id" {
    value = aws_instance.ec2.id
  
}
output "vpc_id" {
    value = aws_vpc.vpc.id
  
}
output "public_ip" {
    value = "http://${aws_instance.ec2.public_ip}:8080"
  
}