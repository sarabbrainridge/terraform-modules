variable "ecs_task_execution_role_name" {
    description = "Name of the ECS task execution role"
}

variable "ecs_task_role_name" {
    description = "Name of the ECS task role"
}

variable "elb_role_name" {
    description = "Name of the ELB iam role"
}

variable "ecr_arn" {}
variable "secret_manager_arn" {}
