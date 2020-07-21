# terraform-ecs-cluster

A playground for running docker containers with AWS ECS. 

## Requirements
- Docker
- Terraform
- An AWS account

## To deploy
- Make sure you have your aws credentials set up
- `terraform init` in root
- `terraform plan` to see what will be created
- `terraform apply`
- TODO: instructions to push docker containers

## To tear down
- `terraform destroy`

## TODOs
- Script to deploy docker images to AWS ECR
- Python/flask hello world
- Java/spring hello world
- Load balancer?
