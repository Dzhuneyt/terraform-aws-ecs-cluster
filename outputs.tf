output "cluster_id" {
  value = aws_ecs_cluster.ecs_cluster.id
}
output "vpc_id" {
  value = data.aws_vpc.main.id
}
output "service_discovery_id" {
  value = aws_service_discovery_private_dns_namespace.dns_namespace.id
}
