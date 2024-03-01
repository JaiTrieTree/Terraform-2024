# This is code that you can use to store the state file remotely in an S3 bucket.
# For this to work properly, wou will need to create your own unique bucket on AWS 

terraform {
  backend "s3" {
    bucket = "tif-bucket-backend2024"
    key    = "dir1/key"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.40"
    }
  }

  required_version = ">= 1.0.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "user_tif" {
  name = "user-tif"
  tags = {
    department = "DEVOPS"
  }
}