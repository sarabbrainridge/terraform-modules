resource "aws_security_group" "alb_sg_tf_prereq" {
    name = var.alb_sg_name
    description = "Security group for ALB"
    vpc_id = -var.vpc_id
    
    ingress {
        from_port = var.alb_port
        to_port = var.alb_port
        protocol = "tcp"
        cidr_blocks = [var.vpc_cidr]
        description = "Allow TCP Traffic from inside VPC"
    }
    
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [var.vpc_cidr]
        description = "Allow HTTPS Traffic from inside VPC"
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "ecs_sg_tf_prereq" {
    name = var.ecs_sg_name
    description = "Security group for ECS"
    vpc_id = var.vpc_id

    # Allow traffic from trusted IP range or ALB
    ingress {
        from_port = var.container_port
        to_port = var.container_port
        protocol = "tcp"
        security_groups = [aws_security_group.alb_sg_tf_prereq.id]
        description = "Allow TCP Traffic from ALB"
    }

    # Allow all outbound traffic
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# Create Security Group for RDS
resource "aws_security_group" "aurora_sg_tf_prereq" {
    name = var.aurora_sg_name
    description = "Allow ECS tasks to access Aurora PostgreSQL"
    vpc_id = var.vpc_id
    
    ingress {
        from_port = var.db_port
        to_port = var.db_port
        protocol = "tcp"
        security_groups = [aws_security_group.ecs_sg_tf_prereq.id]
        description = "Allow TCP Traffic from ECS"
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# Create Security Group for Secret Manager resource "aws_security_group" "sm_sg_tf_prereq" {
    name = var.sm_sg_name
    description = "Allow Secret Manager to access ECS"
    vpc_id = var.vpc_id

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        security_groups = [aws_security_group.ecs_sg_tf_prereq.id]
        description = "Allow TCP Traffic from ECS"
    }

    egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        security_groups = [aws_security_group.ecs_sg_tf_prereq.id]
        description = "Allow TCP Traffic from ECS"
    }
}


