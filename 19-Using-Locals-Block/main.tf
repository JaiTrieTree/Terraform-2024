/*
A locals block in Terraform is used to define local variables within your 
Terraform configuration. Local variables can simplify configurations, 
making them easier to understand and maintain by allowing you to assign names to 
intermediate values and reuse those values without repeating complex expressions.
*/

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = local.ami_id
  instance_type = "t2.micro"

  tags = merge(
    local.common_tags,
    {
      Name = "ExampleInstance"
    }
  )
}


