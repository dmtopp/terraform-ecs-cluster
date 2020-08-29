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

## Gotchas
- If the `AWSServiceRoleForECS` role has not been created for your account, terraform may fail on the first `terraform apply`.  It should work if re-ran, otherwise you can [manually create the role in AWS](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using-service-linked-roles.html).

## To build docker images
Go to the ECR repository in AWS and click "view push commands" 😁
