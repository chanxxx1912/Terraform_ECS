resource "aws_ecs_cluster" "ecs_cluster" {
    name  = var.cluster_name
}


resource "aws_ecs_task_definition" "task_definition" {
  family             = "Terraform-ECS-Demo"
  execution_role_arn = "arn:aws:iam::xxxxxxxx:role/ecsTaskExecutionRole"
  memory             = 1024
  cpu                = 512
  container_definitions = jsonencode([
    {
      name      = "Deployment"
      image     = "nginx:latest"
      cpu       = 512
      memory    = 1024
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
  tags = merge(
    local.common_tags,
    {
      Name = "Deploymnet"
    }
  )
}

resource "aws_ecs_service" "nginx" {
  name            = "ecs"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = 3
}
