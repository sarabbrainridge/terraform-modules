resource "aws_iam_role" "ecs_task_execution_role_tf_prereq" {
    name var.ecs_task_execution_role_name
    assume_role_policy jsonencode({
        Version "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Principal = {
                    Service "ecs-tasks.amazonaws.com"
                }
            }
        ]
    })
}

resource "aws_iam_role" "ecs_task_role_tf_prereq" {
    name= var.ecs_task_role_name
    assume_role_policy jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Principal = {
                    Service = "ecs-tasks.amazonaws.com"
                }
            }
        ]    
    })
}

resource "aws_iam_role" "elb_role_tf_prereq" {
    name var.elb_role_name
    assume_role_policy jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Principal = {
                    Service "elasticloadbalancing.amazonaws.com"
                }
            }
        ]
    })
}


resource "aws_iam_policy" "ecs_execution_custom_policy" {
    name = "ecs-execution-custom-policy"
    description = "Policy for ECS task execution"

    # Custom permissions to interact with CloudWatch Logs, ECR, SSM, Secrets Manager
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action [
                    "logs:CreateLogStream",
                    "logs: PutLogEvents"
                ]
                Effect = "Allow"
                Resource = "*"
            },
            {
                Action = [
                    "ecr:GetAuthorizationToken"
                ]
                Effect = "Allow"
                Resource = "*"
            },
            {
                Action = [
                    "ecr:BatchGetImage",
                    "ecr:GetDownloadUrlForLayer",
                    "ecr:BatchCheckLayerAvailability"
                ]
                Effect = "Allow"
                Resource = var.ecr_arn
            },
            {
                Action = [
                    "ssm:GetParameters",
                    "ssm:GetParameter"
                    # use ssm to log into ecs container
                ]
                Effect = "Allow"
                #Resource = "arn:aws:ssm: REGION: ACCOUNT_ID: parameter/SSM_PARAMETER_NAME"
                Resource = var.ecr_arn
            },
            {
                Action = [
                    "secretsmanager: GetSecretValue"
                ]
                Effect = "Allow"
                Resource = var.secret_manager_arn
            },
        ]
    })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_role_policy_attachment" {
    policy_arn aws_iam_policy.ecs_execution_custom_policy.arn
    role = aws_iam_role.ecs_task_execution_role_tf_prereq.name
}


resource "aws_iam_policy" "ecs_task_custom_policy" {
    name = "ecs-task-custom-policy"
    description = "Policy for ECS task to interact with ELB, RDS, and SSM"

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            #ELB Permissions
            {
                Action = [
                    "elasticloadbalancing: DescribeLoadBalancers",
                    "elasticloadbalancing: DescribeTargetGroups",
                    "elasticloadbalancing: RegisterTargets",
                    "elasticloadbalancing: DeregisterTargets"
                ]
                Effect = "Allow"
                Resource = "*"
            }
            # RDS Permissions
            {
                Action = [
                    "rds:DescribeDBInstances",
                    "rds:DescribeDBClusters"
                ]
                Effect - "Allow"
                Resource "*" # var.db_arn
            },
            # SSM Permissions (for Parameter Store access)
            {
                Action = [
                    "ssm:GetParameters",
                    "ssm:GetParameter"
                ]
                Effect = "Allow"
                Resource = "*"
                #Resource = "arn:aws:ssm: REGION: ACCOUNT_ID: parameter/SSM_PARAMETER_NAME"
            }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "ecs_task_role_policy_attachment" {
    policy_arn = aws_iam_policy.ecs_task_custom_policy.arn
    role = aws_iam_role.ecs_task_role_tf_prereq.name
}

resource "aws_iam_policy" "elb_custom_policy" {
    name = "elb-custom-policy"
    description = "Policy for ELB to write to s3 bucket"

    policy = jsonencode({
        Version "2012-10-17"
        Statement = [
            {
                Action = [
                    "s3:PutObject"
                    #"s3:PutObjectACL"
                ]
                Effect = "Allow"
                Resource = "*"
            },
        ]
    })
}

resource "aws_iam_role_policy_attachment" "elb_custom_policy_attachment" {
    policy_arn = aws_iam_policy.elb_custom_policy.arn
    role = aws_iam_role.elb_role_tf_prereq.name
}
