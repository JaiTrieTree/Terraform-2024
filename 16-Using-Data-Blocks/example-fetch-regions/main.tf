provider "aws" {
  region = "us-east-1"
}

data "aws_regions" "available" {}

output "available_regions" {
  value = data.aws_regions.available.names
}
