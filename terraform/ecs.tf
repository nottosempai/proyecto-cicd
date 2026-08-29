resource "aws_ecs_cluster" "aplicacion" {
  name = "proyecto-cicd"

  tags = {
    Proyecto = "proyecto-cicd"
  }
}

resource "aws_cloudwatch_log_group" "aplicacion" {
  name              = "/ecs/proyecto-cicd"
  retention_in_days = 7
}

resource "aws_ecs_task_definition" "aplicacion" {
  family                   = "proyecto-cicd"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode([
    {
      name      = "proyecto-cicd"
      image     = "${aws_ecr_repository.aplicacion.repository_url}:primera-version"
      essential = true

      portMappings = [
        {
          containerPort = 5000
          hostPort      = 5000
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-group         = aws_cloudwatch_log_group.aplicacion.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "aplicacion"
        }
      }
    }
  ])

  depends_on = [
    aws_iam_role_policy_attachment.ecs_task_execution
  ]

  tags = {
    Proyecto = "proyecto-cicd"
  }
}

resource "aws_ecs_service" "aplicacion" {
  name            = "proyecto-cicd"
  cluster         = aws_ecs_cluster.aplicacion.id
  task_definition = aws_ecs_task_definition.aplicacion.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets = [
      aws_subnet.publica_1.id,
      aws_subnet.publica_2.id
    ]

    security_groups  = [aws_security_group.ecs.id]
    assign_public_ip = true
  }

  tags = {
    Proyecto = "proyecto-cicd"
  }
}


#Esta red permitirá que la tarea de ECS obtenga una IP pública, descargue la imagen desde ECR y responda por el puerto 5000.