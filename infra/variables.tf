variable "app_name" {
  description = "Name of the application"
  type        = string
  default     = "simple-typescript-app"
}

variable "app_version" {
  description = "Version of the application image"
  type        = string
  default     = "latest"
}

variable "replicas" {
  description = "Number of replicas for the deployment"
  type        = number
  default     = 2
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
  default     = 3000
}

variable "node_port" {
  description = "NodePort for the service"
  type        = number
  default     = 30000
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "resource_limits" {
  description = "Resource limits for containers"
  type = object({
    cpu    = string
    memory = string
  })
  default = {
    cpu    = "100m"
    memory = "128Mi"
  }
}

variable "resource_requests" {
  description = "Resource requests for containers"
  type = object({
    cpu    = string
    memory = string
  })
  default = {
    cpu    = "50m"
    memory = "64Mi"
  }
}
