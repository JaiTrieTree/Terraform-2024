/*
timestamp Function: This function returns the current date and time in UTC in RFC 3339 format. In Terraform, it's commonly used to generate unique names or to record the time of resource creation.
formatdate Function: This function formats timestamps into human-readable date formats. Here, formatdate("YYYYMMDD", timestamp()) formats the current timestamp into a string like 20240228, representing February 28th, 2024.
join Function: This function concatenates a list of strings using a specified separator. In this example, join("-", ["tf-example", formatdate("YYYYMMDD", timestamp())]) concatenates "tf-example" with the current date, resulting in a unique bucket name like tf-example-20240228.
*/
terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 4.40"
        }
    }
    
    required_version = ">= 1.4.6"
    
}

provider "aws" {
  region = "us-west-1"
}

resource "aws_s3_bucket" "example_bucket" {
  # Generates a bucket name by concatenating strings with the current timestamp
  bucket = join("-", ["tf-example", formatdate("YYYYMMDD", timestamp())])
  
  tags = {
    Name = "ExampleBucket"
  }
}
