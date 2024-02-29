variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to access the web server"
  type        = list(string)
  default     = ["192.168.1.0/24", "10.0.2.0/24"] # Example CIDR blocks
}
