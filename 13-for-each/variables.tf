# Declare a map variable to associate instance identifiers with availability zones
variable "instance_azs" {
  description = "A map of instances and their target availability zones"
  type        = map(string)
  # Default map of instance identifiers to availability zones
  default = {
    "instance1" = "us-east-1a",
    "instance2" = "us-east-1b",
    "instance3" = "us-east-1c"
  }
}
