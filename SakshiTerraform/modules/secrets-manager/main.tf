resource "aws_secretsmanager_secret" "db_secret_tf_prereq" {
    name var.secret_name
    description = "Secret for DB"
    tags = {
        Environment = var.environment
        Owner = var.owner
    }
}

resource "aws_secretsmanager_secret_version" "db_secret_version_tf_prereq" {
    secret_id = aws_secretsmanager_secret.db_secret_tf_prereq.id
    secret_string = jsonencode({
        DB_DATABASE = var.DB_DATABASE
        DB_DRIVER = var.DB_DRIVER
        DB_PASSWORD = var.DB_PASSWORD
        DB_PORT = var.DB_PORT
        DB_USER = var.DB_USER
        DB_SERVER = var.DB_SERVER
    })
}
