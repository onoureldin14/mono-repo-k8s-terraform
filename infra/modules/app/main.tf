# Local values for common configuration
locals {
  common_labels = merge({
    app     = var.app_name
    version = var.app_version
  }, var.labels)
}

# Kubernetes Deployment (conditional)
resource "kubernetes_deployment" "app" {
  count = var.workload_type == "deployment" ? 1 : 0

  metadata {
    name      = var.app_name
    namespace = var.namespace
    labels    = local.common_labels
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
            limits   = var.resource_limits
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

# Kubernetes DaemonSet (conditional)
resource "kubernetes_daemonset" "app" {
  count = var.workload_type == "daemonset" ? 1 : 0

  metadata {
    name      = var.app_name
    namespace = var.namespace
    labels    = local.common_labels
  }

  spec {
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
            limits   = var.resource_limits
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

# Kubernetes Service (works for both deployment and daemonset)
resource "kubernetes_service" "app" {
  metadata {
    name      = "${var.app_name}-service"
    namespace = var.namespace
    labels    = local.common_labels
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