variable "service_name" {}
variable "cluster_id" {}
variable "docker_image" {}
variable "alb_listener_arn" {}

data template_file task_definition {
  template = file("${path.module}/service.json")
  vars = {
    service_name = var.service_name
    docker_image = var.docker_image
  }
}

data aws_iam_role ecs_task_execution_role {
  name = "ecsTaskExecutionRole"
}

resource aws_alb_target_group fargate_target_group {
  name = "${var.service_name}-target-group"
  port = 8080
  protocol = "HTTP"
  vpc_id = "vpc-dac077a0"
  target_type = "ip"
}

//resource aws_alb_target_group_attachment fargate_target_group_attachement {
//  target_group_arn = aws_alb_target_group.fargate_target_group.arn
//  target_id = // need ip address here?  not sure
//  port = 8080
//}

resource aws_alb_listener_rule fargate_listener_rule {
  listener_arn = var.alb_listener_arn

  action {
    type = "forward"
    target_group_arn = aws_alb_target_group.fargate_target_group.arn
  }

  condition {
    path_pattern {
      values = [var.service_name]
    }
  }
}

resource aws_ecs_task_definition service_task_definition {
  family = "service"
  container_definitions = data.template_file.task_definition.rendered
  requires_compatibilities = ["FARGATE"]
  cpu = "256"
  memory = "512"
  network_mode = "awsvpc"
  execution_role_arn = data.aws_iam_role.ecs_task_execution_role.arn
}

resource aws_ecs_service service {
  name            = var.service_name
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.service_task_definition.arn
  desired_count   = 1
  launch_type = "FARGATE"

  network_configuration {
    subnets = ["subnet-0d1a9bf7dc3298adc"] // private subnet
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.fargate_target_group.arn
    container_name   = var.service_name
    container_port   = 8080
  }
}
