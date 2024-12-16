module "ecr" {
    source = "./modules/ecr"
    ecr_name = var.ecr_name
}

module "secrets-manager" {
    source = "./modules/secrets-manager"
    secret_name = var.secret_name
    DB_DATABASE = var.DB_DATABASE
    DB_DRIVER = var.DB_DRIVER
    DB_PASSWORD = var.DB_PASSWORD
    DB_PORT = var.DB_PORT
    DB_USER = var.DB_USER
    DB_SERVER = var.DB_SERVER
    environment = var.environment
    Owner = var.owner
}

module "sg" {
    source = "./modules/sg"
    vpc_id = var.vpc_id
    aurora_sg_name = var.aurora_sg_name
    alb_sg_name = var.alb_sg_name
    ecs_sg_name = var.ecs_sg_name
    db_port = var.db_port
    alb_port = var.alb_port
    container_port = var.container_port
    vpc_cidr = var.vpc_cidr
}

module "iam" {
    source = "./modules/iam"
    ecs_task_execution_role_name = var.ecs_task_execution_role_name
    ecs_task_role_name = var.ecs_task_role_name
    elb_role_name= var.elb_role_name
    secret_manager_arn = module.secrets-manager.secret_manager_arn
    ecr_arn = module.ecr.ecr_arn
}
