terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~=6.0"
    }
  }
  backend "s3" {
    bucket = "practice-bucket-state"
    region = "us-east-1"
    use_lockfile = true
    key = "terraform.tfstate"
          
  }
}
