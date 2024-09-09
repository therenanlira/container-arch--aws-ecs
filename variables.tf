#### GENERAL CONFIGURATION ####

variable "region" {
  description = "The region where the resources will be created"
  type        = string
}

#### NETWORK CONFIGURATION ####

variable "vpc_id" {
  description = "The SSM parameter name for the VPC ID"
  type        = string
}

variable "private_subnets" {
  description = "The SSM parameter name for the private subnet 1"
  type        = list(string)
}

#### ECS APP CONFIGURATION ####

variable "service_name" {
  description = "The name of the ECS service"
  type        = string
}

variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

variable "service_port" {
  description = "The port on which the service listens"
  type        = number
}

variable "service_cpu" {
  description = "The number of CPU units to reserve for the service"
  type        = number
}

variable "service_memory" {
  description = "The amount of memory to reserve for the service"
  type        = number
}

variable "service_listener_arn" {
  description = "The listener rule for the service"
  type        = string
}

variable "service_task_execution_role_arn" {
  description = "The task execution role for the service"
  type        = string
}

variable "service_healthcheck" {
  description = "The healthcheck for the service"
  type        = map(string)
}

variable "service_launch_type" {
  description = "The launch type for the service"
  type        = string
}

variable "service_task_count" {
  description = "The number of tasks to run"
  type        = number
}

variable "service_hosts" {
  description = "The hosts for the service"
  type        = list(string)
}

#### ECS TASK DEFINITION ####

variable "environment_variables" {
  description = "The environment variables for the task definition"
  type = list(object({
    name  = string
    value = string
  }))
}

variable "capabilities" {
  description = "The capabilities for the task definition"
  type        = list(string)
}
