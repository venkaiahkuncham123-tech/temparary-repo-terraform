variable "vpc_cidr" {
    type = string
    default = "172.0.0.0/16"
  
}
variable "public_subnet_cidr" {
    type = string
    default = "172.0.1.0/24"
  
}
variable "public_route" {
    type = string
    default = "0.0.0.0/0"
  
}
variable "private_cidr" {
    type = string
    default = "172.0.2.0/24"
  
}
variable "private_rt_cidr" {
    type = string
    default = "0.0.0.0/0"
  
}
variable "itype" {
    type = string
    default = "t3.small"
  
}
variable "common_tags" {
    type = string
    default = "Phonepe"
  
}