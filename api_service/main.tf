variable "service_name" {}
variable "cluster_id" {}
variable "docker_image" {}

data template_file task_definition {
  template = file("service.json")
  vars = {
    service_name = var.service_name
    docker_image = var.docker_image
  }
}

resource aws_ecs_task_definition service_task_definition {
  family = "service"
  container_definitions = data.template_file.task_definition.rendered
}

resource aws_ecs_service service {
  name            = var.service_name
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.service_task_definition.arn
  desired_count   = 1
  launch_type = "FARGATE"
}
