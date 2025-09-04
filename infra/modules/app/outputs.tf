output "workload_type" {
  description = "The type of workload created (deployment or daemonset)"
  value       = var.workload_type
}

output "app_name" {
  description = "Name of the application"
  value       = var.app_name
}

output "app_image" {
  description = "Container image used"
  value       = "onoureldin14/${var.app_name}:${var.app_version}"
}

output "service_name" {
  description = "Name of the Kubernetes service"
  value       = kubernetes_service.app.metadata[0].name
}

output "service_node_port" {
  description = "Node port for accessing the service"
  value       = var.node_port
}

output "access_url" {
  description = "URL to access the application (requires minikube or similar)"
  value       = "http://$(minikube ip):${var.node_port}"
}

output "namespace" {
  description = "Kubernetes namespace where resources are created"
  value       = var.namespace
}

output "deployment_name" {
  description = "Name of the deployment (if created)"
  value       = var.workload_type == "deployment" ? kubernetes_deployment.app[0].metadata[0].name : null
}

output "daemonset_name" {
  description = "Name of the daemonset (if created)"
  value       = var.workload_type == "daemonset" ? kubernetes_daemonset.app[0].metadata[0].name : null
}

output "replicas" {
  description = "Number of replicas (only applicable for deployments)"
  value       = var.workload_type == "deployment" ? var.replicas : null
}
