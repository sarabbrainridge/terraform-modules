output "aurora_security_group_id" {
    value = aws_security_group.aurora_sg_tf_prereq.id
}

output "alb_security_group_id" {
    value = aws_security_group.alb_sg_tf_prereq.id
}

output "ecs_security_group_id" {
    value aws_security_group.ecs_sg_tf_prereq.id
}
