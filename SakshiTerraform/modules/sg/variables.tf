variable "aurora_sg_name" {
    description = "Name of the Security Group for Aurora"
}

variable "alb_sg_name" {
    description "Name of the Security Group for ALB"
}

variable "ecs_sg_name" {
    description "Name of the Security Group for ECS"
}

variable "vpc_id" {}
variable "container_port" {}
variable "db_port" {}
variable "alb_port" {}
variable "vpc_cidr" {}
