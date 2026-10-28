variable "vpc-cidr" {
  type    = string
  default = "10.0.0.0/16"
}
variable "vpc_name" {
  type    = string
  default = "terraform-vpc"
}
variable "subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}
variable "az" {
  type    = string
  default = "us-east-1a"

}
variable "private_subnet_cidr_block" {
  type    = string
  default = "10.0.2.0/24"
}
variable "private_az" {
  type    = string
  default = "us-east-1b"

}
variable "region" {
  type    = string
  default = "Production"

}