Create AWS ECR repository
```bash
aws ecr create-repository --repository-name aws-fargate-template --region eu-west-1
```

Create execution role

```bash
aws iam create-role --role-name ecsTaskExecutionRole --assume-role-policy-document file://$HOME/go/src/github.com/koschos/promo-proxy/aws/fargate/ecs-tasks-trust-policy.json
# attach policy
aws iam attach-role-policy --role-name ecsTaskExecutionRole --policy-arn arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy
```

Register task definition
```bash
aws ecs register-task-definition --region eu-west-1 --cli-input-json file://$HOME/go/src/github.com/koschos/aws-fargate-template/aws/task-definition.json
```

Create ESC cluster
```bash
aws ecs create-cluster --region eu-west-1 --cluster-name aws-fargate-template
```

Create Fargate service
```bash
aws ecs create-service --region eu-west-1 --cluster aws-fargate-template --service-name aws-fargate-template-service --task-definition aws-fargate-template-family:4 --desired-count 1 --launch-type "FARGATE" --network-configuration "awsvpcConfiguration={subnets=[subnet-0604ed2a62b2b8a00],securityGroups=[sg-03c7ce81d33023b88],assignPublicIp=ENABLED}"
```