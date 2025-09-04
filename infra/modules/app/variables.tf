variable "app_name" {
  description = "Name of the application"
  type        = string
  default     = "simple-typescript-app"
}

variable "app_version" {
  description = "Version tag for the container image"
  type        = string
  default     = "latest"
}

variable "workload_type" {
  description = "Type of Kubernetes workload to create (deployment or daemonset)"
  type        = string
  default     = "deployment"
  validation {
    condition     = contains(["deployment", "daemonset"], var.workload_type)
    error_message = "workload_type must be either 'deployment' or 'daemonset'."
  }
}

variable "replicas" {
  description = "Number of replicas for deployment (ignored for daemonset)"
  type        = number
  default     = 2
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
  default     = 3000
}

variable "environment" {
  description = "Environment name (e.g., production, staging, development)"
  type        = string
  default     = "production"
}

variable "resource_limits" {
  description = "Resource limits for the container"
  type        = map(string)
  default = {
    cpu    = "100m"
    memory = "128Mi"
  }
}

variable "resource_requests" {
  description = "Resource requests for the container"
  type        = map(string)
  default = {
    cpu    = "50m"
    memory = "64Mi"
  }
}

variable "node_port" {
  description = "Node port for the service"
  type        = number
  default     = 30000
}

variable "labels" {
  description = "Additional labels to add to resources"
  type        = map(string)
  default     = {}
}

variable "namespace" {
  description = "Kubernetes namespace to create resources in"
  type        = string
  default     = "default"
}
