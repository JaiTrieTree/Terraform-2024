provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("keys/deployer-key.pub") # Ensure you have a deployer.pub file in your directory
}

resource "aws_instance" "example" {
  ami           = "ami-0440d3b780d96b29d" # Use an appropriate AMI for your region
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer.key_name

  # Security group to allow SSH access
  vpc_security_group_ids = [aws_security_group.instance_sg.id, aws_security_group.http_sg.id]

  provisioner "remote-exec" {
    # Connection block specifies how to connect
    connection {
      type        = "ssh"
      user        = "ec2-user"                                               # or appropriate user for your AMI
      private_key = file("keys/deployer-key") # Path to your private SSH key
      host        = self.public_ip
    }

    # Commands to run on the instance
    inline = [
      "sudo yum update -y",        # Update all packages, adjust command for your OS
      "sudo yum install -y nginx", # Install Nginx, adjust command for your OS
      "sudo systemctl start nginx" # Start Nginx
    ]
  }
}

resource "aws_security_group" "instance_sg" {
  name        = "instance-access1"
  description = "Allow inbound SSH access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "http_sg" {
  name        = "instance-access2"
  description = "Allow inbound SSH access"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
