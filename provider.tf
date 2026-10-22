terraform   {
    required_providers {
            aws ={
            source = "hashicorp/aws"
            version = "~>6.0"
    }
                }
    backend "s3" {
    bucket = "state-locking-bucket-aws-4"
    region = "us-east-1"
    key = "./terraform.tfstate"
    use_lockfile = true
    
}
}
provider "aws" {
    region = "us-east-1"
}
provider "aws" {
    region = "eu-north-1"
    alias = "north"
}

