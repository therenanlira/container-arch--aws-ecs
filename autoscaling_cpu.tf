locals {
  cpu_appautoscaling_resource_name = "ecs-cpu"
}

resource "aws_appautoscaling_policy" "ecs_cpu_scale_out" {
  count = var.scale_type == "CPU" ? 1 : 0
  name  = "${var.cluster_name}--${var.service_name}--${local.cpu_appautoscaling_resource_name}--scale-out-policy"

  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension

  policy_type = "StepScaling"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.scale_out_cooldown
    metric_aggregation_type = var.scale_out_statistic

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = var.scale_out_adjustment
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "ecs_cpu_scale_out_alarm" {
  count = var.scale_type == "CPU" ? 1 : 0

  alarm_name        = "${var.cluster_name}--${var.service_name}--${local.cpu_appautoscaling_resource_name}--scale-out-alarm"
  alarm_description = "Scale out when CPU exceeds ${var.scale_out_cpu_threshold}%"

  comparison_operator = var.scale_out_comparison_operator
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  statistic           = var.scale_out_statistic

  period             = var.scale_out_period
  evaluation_periods = var.scale_out_evaluation_periods
  threshold          = var.scale_out_cpu_threshold

  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = var.service_name
  }

  alarm_actions = [aws_appautoscaling_policy.ecs_cpu_scale_out[count.index].arn]
}
