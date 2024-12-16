output "ecr_name" {
    value = module.ecr.ecr_name
}

output "ecr_arn" {
    value = module.ecr.ecr_arn
}

output "secret_manager_arn" {
    value = module.secrets-manager.secret_manager_arn
}

output "secret_string" {
    value = module.secrets-manager.secret_string
    sensitive = true
}

output "secret_id" {
    description = "The ID of the Secrets Manager secret"
    value = module.secrets-manager.secret_id
}

output "aurora_security_group_id" {
    value = module.sg.aurora_security_group_id
}

output "alb_security_group_id" {
    value = module.sg.alb_security_group_id
}

output "ecs_security_group_id" {
    value = module.sg.ecs_security_group_id
}
