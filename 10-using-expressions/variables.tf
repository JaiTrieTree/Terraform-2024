variable "use_large_instance" {
  description = "A boolean flag to use a large instance type over a smaller one. When true, uses t2.small; otherwise, uses t2.micro."
  type        = bool
  default     = false
}
