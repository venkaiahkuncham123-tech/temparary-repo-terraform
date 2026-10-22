output "ec2-id" {
    value = aws_instance.ec2.id
}
output "ec2-id-north" {
    value = aws_instance.ec2-north.id
}
output "s3-namregion" {
    value = aws_s3_bucket.s3-name.region
  
}
output "s3-name"{
    value = aws_s3_bucket.s3-name.bucket
}