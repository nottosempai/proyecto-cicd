output "ecr_repository_url" {
  description = "Dirección del repositorio ECR"
  value       = aws_ecr_repository.aplicacion.repository_url
}