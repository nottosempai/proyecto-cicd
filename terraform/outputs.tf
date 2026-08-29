output "ecr_repository_url" {
  description = "Dirección del repositorio ECR"
  value       = aws_ecr_repository.aplicacion.repository_url
}

output "ecs_cluster_name" {
  description = "Nombre del cluster ECS"
  value       = aws_ecs_cluster.aplicacion.name
}

output "ecs_service_name" {
  description = "Nombre del servicio ECS"
  value       = aws_ecs_service.aplicacion.name
}

output "cloudwatch_log_group" {
  description = "Grupo de logs de la aplicación"
  value       = aws_cloudwatch_log_group.aplicacion.name
}