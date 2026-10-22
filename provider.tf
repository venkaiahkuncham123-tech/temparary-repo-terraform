terraform   {
    required_providers {
            aws = "hashicorp/aws"
            version = "~>=6.0"
    }
}
provider "aws" {
    region = "us-east-1"
}
provider "aws" {
    region = "eu-north-1"
    alias = "north"
}