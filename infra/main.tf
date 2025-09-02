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

# Kubernetes Deployment
resource "kubernetes_deployment" "simple_typescript_app" {
  metadata {
    name = var.app_name
    labels = {
      app = var.app_name
    }
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = var.app_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_name
        }
      }

      spec {
        container {
          name  = var.app_name
          image = "onoureldin14/${var.app_name}:${var.app_version}"
          
          port {
            container_port = var.container_port
          }

          env {
            name  = "NODE_ENV"
            value = var.environment
          }

          env {
            name  = "PORT"
            value = tostring(var.container_port)
          }

          resources {
            limits = var.resource_limits
            requests = var.resource_requests
          }

          liveness_probe {
            http_get {
              path = "/health"
              port = var.container_port
            }
            initial_delay_seconds = 30
            period_seconds        = 10
          }

          readiness_probe {
            http_get {
              path = "/health"
              port = var.container_port
            }
            initial_delay_seconds = 5
            period_seconds        = 5
          }
        }
      }
    }
  }
}

# Kubernetes Service
resource "kubernetes_service" "simple_typescript_app" {
  metadata {
    name = "${var.app_name}-service"
    labels = {
      app = var.app_name
    }
  }

  spec {
    type = "NodePort"
    
    selector = {
      app = var.app_name
    }

    port {
      port        = var.container_port
      target_port = var.container_port
      node_port   = var.node_port
    }
  }
}
