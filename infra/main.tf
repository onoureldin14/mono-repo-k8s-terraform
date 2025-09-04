terraform {
  required_version = ">= 1.0"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25"
    }
  }
}

# Configure Kubernetes provider
provider "kubernetes" {
  config_path = "~/.kube/config"
}

# App Module - Creates either Deployment or DaemonSet based on workload_type variable
module "app" {
  source = "./modules/app"

  # Basic configuration
  app_name    = var.app_name
  app_version = var.app_version
  
  # Workload type: "deployment" or "daemonset"
  workload_type = var.workload_type
  
  # Deployment specific (ignored for daemonset)
  replicas = var.replicas
  
  # Container configuration
  container_port = var.container_port
  environment    = var.environment
  
  # Resource configuration
  resource_limits   = var.resource_limits
  resource_requests = var.resource_requests
  
  # Service configuration
  node_port = var.node_port
  
  # Additional labels
  labels = var.labels
  
  # Namespace
  namespace = var.namespace
}
