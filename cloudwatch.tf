resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/ecs/${var.cluster_name}/${var.service_name}"
  retention_in_days = 7
}
