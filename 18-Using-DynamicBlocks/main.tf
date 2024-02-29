/*
Dynamic blocks in Terraform are used to dynamically construct repeatable nested 
blocks within a resource or data configuration based on the contents of a map or 
a list. This feature is particularly useful when you need to create multiple 
similar configuration blocks without hardcoding each one.
*/

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "web_server_sg" {
  name        = "web-server-sg"
  description = "Security group for web server with dynamic ingress rules"

  # Dynamic block for HTTP ingress rules
  dynamic "ingress" {
    for_each = var.allowed_cidr_blocks

    content {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = [ingress.value] # Use the current item from the list
      description = "HTTP access from ${ingress.value}"
    }
  }

  # Dynamic block for HTTPS ingress rules
  dynamic "ingress" {
    for_each = var.allowed_cidr_blocks

    content {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = [ingress.value] # Use the current item from the list
      description = "HTTPS access from ${ingress.value}"
    }
  }

  # Default egress rule: Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
