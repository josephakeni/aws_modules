# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/ecs/${var.ecs_cluster_name}"
  retention_in_days = 30

  tags = {
    Name = "${var.ecs_cluster_name}-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "cb_log_stream" {
  name           = "${var.ecs_cluster_name}-log-stream"
  log_group_name = aws_cloudwatch_log_group.log_group.name
}