terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "tif-server" {
  ami           = "ami-0440d3b780d96b29d"
  instance_type = "t2.micro"

  tags = {
    Name = "AWS-Instance"
  }
}