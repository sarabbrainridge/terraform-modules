# Outputs to pass the secret information to other modules
output "secret_manager_arn" {
    value = aws_secretsmanager_secret.db_secret_tf_prereq.arn
}

output "secret_string" {
    value = aws_secretsmanager_secret_version.db_secret_version_tf_prereq.secret_string
}

output "secret_id" {
    description = "The ID of the Secrets Manager secret"
    value = aws_secretsmanager_secret.db_secret_tf_prereq.name
}
