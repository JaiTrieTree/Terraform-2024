provider "aws" {
  region = var.region
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  tags = {
    Name = "ExampleInstance"
  }
}
