resource "aws_ecr_repository" "aplicacion" {
  name                 = "proyecto-cicd"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Proyecto     = "proyecto-cicd"
    Administrado = "Terraform"
  }
}

#IMMUTABLE evita reemplazar accidentalmente una imagen existente que tenga la misma etiqueta.