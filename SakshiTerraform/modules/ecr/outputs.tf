output "ecr_name" {
    value = aws_ecr_repository.craft_ecr_tf_prereq.name
}

output "ecr_arn" {
    value = aws_ecr_repository.craft_ecr_tf_prereq.arn
}
