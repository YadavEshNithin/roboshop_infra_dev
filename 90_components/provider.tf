terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.98.0"
    }
  }


  backend "s3" {
    bucket         = "84sawsbucket-dev"
    key            = "aws_bucket_ncomp_dev"
    region         = "us-east-1"
    encrypt      = true  
    use_lockfile = true  #S3 native locking
  }
}



provider "aws" {
  region = "us-east-1"
}
