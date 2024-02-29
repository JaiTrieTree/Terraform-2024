# This Terraform configuration was written 2024

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.20"
    }
  }

  required_version = ">= 1.0"
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  # To download the latest module, simply omit the version argument. 
  # However, if you wanted a specific module version, you could list it as shown below.
  # This version was released in 2024.
  version = "5.5.2"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway = var.vpc_enable_nat_gateway

  tags = var.vpc_tags
}

module "ec2_instances" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.0.0"

  name  = "Cluster-A-${count.index}"
  count = 3

  ami                    = "ami-0440d3b780d96b29d"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "testing"
    Why         = "Because we can"
  }
}