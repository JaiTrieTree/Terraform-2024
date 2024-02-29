locals {
  common_tags = {
    Project     = "MyProject"
    Environment = "Development"
  }

  ami_id = "ami-0440d3b780d96b29d" # Example AMI ID, replace with a valid one for your region
}
