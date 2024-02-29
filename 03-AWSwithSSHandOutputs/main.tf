resource "aws_instance" "tif-key" {
  ami           = "ami-0440d3b780d96b29d"
  instance_type = "t2.micro"
  key_name      = "aws_key"
  vpc_security_group_ids = [
    aws_security_group.sg_ssh.id,
    aws_security_group.sg_https.id,
    aws_security_group.sg_http.id
  ]


  tags = {
    Name = "tif-key"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQChCt5XdupZYL33QA5/I8OHd8nNPB9Ow6LgD7buZ58t7gow7LFFRCE3bC54mZbv2vHk9I7eoPFijhL+/eH6BN43gnaqr6DB1HllrHcFy08bl6Mt8j60fJqnE0zQEo2dYQUdku5CSAKcvpgLNdorcTCRFT/PGqtZX5LIMKrLLNpg8/yvdS8Aqq1zWpkSjQMFTqv/ovoNGmP/wkizI642Rw6ZPGXJtu0dnwH7BQSPZJYYFk7Qsu3IllGmt/4FYPx8AZInwsMXueUR5Vnige/ppIVx/EUyK+78AKVsClByD9hs4CtLC9xkwuRzBh65yC2WuBOb2YsjxcveotyGs+WD1vOCeWewkioAAFaI60l9QmzbvLQyTVZqMnxNRRT9QKV4t0y/e0/yvwZtk38YntxurA24jIbYAt7r51yne/QTACNlKIW6JbzP1mCgE2YhxolQ7nkFLpTVjSVoAOLCjYPFnYO/l4zkMV72Aw+YBI2qz+DkPjzMJtn8C9ANEjU9smrFyWc= dhmar@Jai"
}

resource "aws_security_group" "sg_ssh" {
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }
}

resource "aws_security_group" "sg_https" {
  ingress {
    cidr_blocks = ["192.168.0.0/16"]
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }
}

resource "aws_security_group" "sg_http" {
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }
}