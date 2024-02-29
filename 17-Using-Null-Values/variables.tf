variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = null # Default to null, indicating no specific instance type is chosen
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default    = "ami-0440d3b780d96b29d"
}
