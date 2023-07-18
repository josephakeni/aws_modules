output "ecs_task_execution_role" {
  value = aws_iam_role.ecs_task_execution_role.arn
}

output "dynamodb" {
  value = aws_iam_policy.dynamodb.arn
}

output "ecs_container_service_autoscale_role" {
  value = aws_iam_role.ecs_container_service_autoscale_role.arn
}
