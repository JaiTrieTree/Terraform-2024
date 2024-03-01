provider "aws" {
  region = "us-east-1"
}

# Updated expression to use t2.small and t2.micro
resource "aws_instance" "example" {
  ami           = "ami-0440d3b780d96b29d" # Ensure this AMI ID is valid in your AWS region
  instance_type = var.use_large_instance ? "t2.small" : "t2.micro"

  tags = {
    Name = "TIFInstance"
  }
}
/*
#Instance Types: The instance_type attribute now uses t2.small and t2.micro 
as the options. The var.use_large_instance variable determines which instance 
type to use. If use_large_instance is true, the instance type will be t2.small; 
otherwise, it will default to t2.micro.
*/