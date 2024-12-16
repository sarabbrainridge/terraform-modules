variable "region" {
    description = "AWS region"
    default = "ca-central-1"
}

variable "cluster_name" {
    default = "craftcms-cluster"
}

variable "aws_account_id" {
    description = "AWS Account ID"
    default = "140023371138" # Replace with intact AWS Account ID
}

variable "service_name" {
    default = "craftcms-service"
}

variable "task_cpu" {
    default = 256
}

variable "task_memory" {
    default = 512
}

variable "container_port" {
    default = 8080
}

variable "alb_port" {
    default = 80
}

variable "db_port" {
    default = 5432
}

variable "ecr_image_url_craft" {
    default = "140023371138.dkr.ecr.ca-central-1.amazonaws.com/craftcms:5.0.0"
}

variable "vpc_id" {
    description = "Existing VPC ID"
}

variable "ecr_name" {
    description = "Name of the ECR"
    #default = "craftcms_image_repo_test_prereq"
}

variable "aurora_sg_name" {
    description "Name of the Security Group for Aurora"
}

variable "alb_sg_name" {
    description = "Name of the Security Group for ALB"
}

variable "ecs_sg_name" {
    description = "Name of the Security Group for ECS"
}

variable "vpc_cidr" {}
variable "secret_name" {}
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

variable "ecs_task_execution_role_name" {
    description = "Name of the ECS task execution role"
}

variable "ecs_task_role_name" {
    description = "Name of the ECS task role"
}

variable "elb_role_name" {
    description = "Name of the ELB IAM role"
}
