terraform {
  required_version = "0.12.28"

  required_providers {
    aws = "2.70.0"
  }
}

provider "aws" {
  version = "2.70.0"
  region  = "us-east-1"
}

data "aws_caller_identity" "current" {}

resource "aws_ecs_cluster" "fargate_ecs_cluster" {
  name = "fargate-ecs-cluster"
  capacity_providers = ["FARGATE"]

  setting {
    name = "containerInsights"
    value = "disabled"
  }
}

resource aws_alb fargate_cluster_load_balancer {
  name = "fargate-cluster-load-balancer"
  subnets = ["subnet-d9af34be", "subnet-a3adc9ff"] // public subnets
}

resource aws_alb_listener fargate_cluster_listener {
  load_balancer_arn = aws_alb.fargate_cluster_load_balancer.arn
  port = 80

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Not authorized, dude."
      status_code = "403"
    }
  }
}

module "node_api" {
  source = "./api_service"
  cluster_id = aws_ecs_cluster.fargate_ecs_cluster.id
  docker_image = "${data.aws_caller_identity.current.account_id}.dkr.ecr.us-east-1.amazonaws.com/node-hello-world:latest"
  service_name = "node-api"
  alb_listener_arn = aws_alb_listener.fargate_cluster_listener.arn
}
