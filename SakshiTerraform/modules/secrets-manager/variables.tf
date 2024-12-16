variable "secret_name" {
    description = "The name of the secret in Secrets Manager"
}

variable "DB_DATABASE" {}
variable "DB_DRIVER" {}
variable "DB_PASSWORD" {}
variable "DB_PORT" {}
variable "DB_USER" {}
variable "DB_SERVER" {}

variable "environment" {
    description = "Environment tag for the secret"
}

variable "owner" {
    description = "Owner tag for the secret"
}
