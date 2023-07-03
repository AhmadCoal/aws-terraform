output "aws_region_azs" {
  value       = data.aws_availability_zones.available.names
}

# output "aws_instance" {
#   value = "${aws_instance.wpserver[0].id}"
# }