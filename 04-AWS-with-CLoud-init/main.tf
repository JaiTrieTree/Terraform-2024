resource "aws_instance" "tif-cloud-init" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  key_name      = "aws_key"
  vpc_security_group_ids = [
    aws_security_group.sg_ssh.id,
    aws_security_group.sg_https.id,
    aws_security_group.sg_http.id
  ]

  user_data = file("scripts/apache-mkdocs.yaml")

  tags = {
    Name = "Cloud-Init"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC04xbw+xI7j1fEQsK3EpXJxOLDC2SnrAQa1gPa2rWDmnM9VcB9nyNjB7K2etAfdne9qOO1buQufnPVBDPkImOAvNgUoeZN55qtD7QTaZltIBinx/m5as0vPcJ7KoNkYaLsYYzlfQwA8GK/4slymg4jDMqXzlBb6d1BUq6Zy5Yb2gLpSsupyasnSHvjtJjuW77GctMs2eN/ijTmtHNZsZdhnKeTPU27u3lM5OcwMnIs2KNvSBYsotyWxvVvwcIokIFANxlJ/TOPSPJadF7W/n+ju6Ym411+NkeUwqTAGjwo+2Hda1NKvYXlu/VlfCkAf7hZSdrWLa/E9lEV+fsM4h8TE62kdq2/LiscZM15mEznolyd+SmS5cipQ99rzyG6mZgDmbDy/QkL7WJHiIHYekMTw15PEe+3HyAQqH1e1CVA8+jlJyQO1W5dKKYmNBpEoMfWczDbzUqtpYmVuHGmbKnsaSYjHuE+CUZ+iVWTFdWYqJqI2cSCYYDgcgkL7opwY18= dhmar@Jai"
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