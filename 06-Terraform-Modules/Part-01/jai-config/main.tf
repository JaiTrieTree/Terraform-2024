provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Jai_VPC"
  }
}

module "webserver-Jai" {
  source     = "../modules/webserver"
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/16"
  ami        = "ami-0440d3b780d96b29d"
  # Remember, select an AMI that exists in your AWS region.
  # If in doubt, use the AMI above and the us-east-1 region.
  instance_type  = "t2.micro"
  webserver_name = "Jai"
}