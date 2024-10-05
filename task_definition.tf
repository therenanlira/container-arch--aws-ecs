locals {
  taskdef_resource_name = "task-def"
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family = "${var.cluster_name}--${var.service_name}--${local.taskdef_resource_name}"

  network_mode             = "awsvpc"
  requires_compatibilities = var.capabilities

  cpu                = var.service_cpu
  memory             = var.service_memory
  execution_role_arn = aws_iam_role.service_execution_role.arn
  task_role_arn      = var.service_task_execution_role_arn

  container_definitions = jsonencode([
    {
      name        = var.service_name
      image       = var.container_image
      cpu         = var.service_cpu
      memory      = var.service_memory
      essential   = true
      environment = var.environment_variables

      portMappings = [
        {
          containerPort = var.service_port
          hostPort      = var.service_port
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.log_group.name
          "awslogs-region"        = var.region
          "awslogs-stream-prefix" = var.service_name
        }
      }

    }
  ])

  tags = {
    Name     = "${var.service_name}--${local.taskdef_resource_name}"
    Resource = "task-definition"
  }
}