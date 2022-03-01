resource "aws_ecr_repository" "dss" {
  name                 = var.ecr.name
  image_tag_mutability = var.ecr.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.ecr.scan_on_push
  }
}