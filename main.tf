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

resource "aws_ecs_cluster" "fargate_ecs_cluster" {
  name = "fargate-ecs-cluster"
  capacity_providers = ["FARGATE"]

  setting {
    name = "containerInsights"
    value = "disabled"
  }
}
