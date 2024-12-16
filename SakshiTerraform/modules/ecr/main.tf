resource "aws_ecr_repository" "craft_ecr_tf_prereq" {
    name = var.ecr_name
    image_tag_mutability = "MUTABLE"
    encryption_configuration {
        encryption_type = "AE256"
    }
}