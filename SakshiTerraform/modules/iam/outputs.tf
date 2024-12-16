output "ecs_task_execution_role_name" {
    description "The name of the ECS task execution role"
    value aws_iam_role.ecs_task_execution_role_tf_prereq.name
}

output "ecs_task_role_name" {
    description = "The name of the ECS task role"
    value = aws_iam_role.ecs_task_role_tf_prereq.name
}

output "elb_role_name" {
    description = "The name of the ELB IAM role to access s3"
    value aws_iam_role.elb_role_tf_prereq.name
}
