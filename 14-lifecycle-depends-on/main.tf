provider "aws" {
  region = "us-east-1"
}

# S3 Bucket Resource
resource "aws_s3_bucket" "example_bucket" {
  bucket = "my-unique-terraform-bucket-2024"

  # Lifecycle block to prevent the bucket from being destroyed if it contains objects
  lifecycle {
    prevent_destroy = true
  }
}

# EC2 Instance Resource
resource "aws_instance" "example_instance" {
  ami           = "ami-0440d3b780d96b29d" # Example AMI, replace with a valid one
  instance_type = "t2.micro"

  # depends_on to ensure this instance is created after the S3 bucket
  depends_on = [aws_s3_bucket.example_bucket]

  tags = {
    Name = "ExampleInstance"
  }
}
