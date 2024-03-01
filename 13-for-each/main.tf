# Specify the AWS provider and set the region to us-east-1
provider "aws" {
  region = "us-east-1"
}

# Define a resource for AWS EC2 instances
resource "aws_instance" "example" {
  # Use for_each to create an instance for each entry in the instance_azs variable
  for_each = var.instance_azs

  # Specify the AMI and instance type for the instances
  ami           = "ami-0440d3b780d96b29d" # Ensure this AMI is available in your region or update accordingly
  instance_type = "t2.micro"
  # Set the availability zone for each instance based on the instance_azs map
  /*
Iteration with for_each
When Terraform iterates over instance_azs with for_each, it assigns each item in the map to a temporary variable named each. This each variable is a complex object with two attributes:
each.key: The key part of the current item (e.g., "instance1").
each.value: The value part of the current item (e.g., "us-east-1a").
  */
  availability_zone = each.value

  # Tag each instance with a unique name based on its key in the instance_azs map
  tags = {
    Name = "Instance-${each.key}"
  }
}
