provider "aws" {
  region = var.region
}

resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type != null ? var.instance_type : "t2.micro" # Conditional logic
# If not passing any value for instance_type, then it will use t2.micro as default
#if you need to pass a value for instance_type, then it will use the value passed in the variable ex: terraform apply -var="instance_type=t2.small"
  tags = {
    Name = "ConditionalInstance"
  }
}
