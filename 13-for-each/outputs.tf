# Output the IDs of the created instances
output "instance_ids" {
  # Use a for expression to transform aws_instance.example into a map of id => instance.id
  value = { for id, instance in aws_instance.example : id => instance.id }
}

# Output the availability zones of the created instances
output "instance_azs" {
  # Use a for expression to transform aws_instance.example into a map of id => instance.availability_zone
  value = { for id, instance in aws_instance.example : id => instance.availability_zone }
}
