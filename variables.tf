variable "ami" {
    type = string
    default = "value"
  
}
variable "vpc_cidr" {
	type = string
	default = "192.168.0.0/16"  
}
variable "sub_az" {
  type = string
  default = "eu-north-1a"
}
variable "subnet_cidr" {
  type = string
	default = "192.168.1.0/24"
}
variable "rt_cidr" {
  type = string
	default = "0.0.0.0/0"
}
variable "sg_cidr" {
  type = list(string)
	default = ["0.0.0.0/0"]
}
