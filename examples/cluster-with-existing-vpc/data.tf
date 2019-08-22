# Get AZs for the current AWS region
data "aws_availability_zones" "available" {
  state = "available"
}
