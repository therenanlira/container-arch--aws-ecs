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

#### NETWORK CONFIGURATION ####

variable "vpc_id" {
  description = "The SSM parameter name for the VPC ID"
  type        = string
}

variable "private_subnets" {
  description = "The SSM parameter name for the private subnet 1"
  type        = list(string)
}
