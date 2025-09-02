output "deployment_name" {
  description = "Name of the Kubernetes deployment"
  value       = kubernetes_deployment.simple_typescript_app.metadata[0].name
}

output "service_name" {
  description = "Name of the Kubernetes service"
  value       = kubernetes_service.simple_typescript_app.metadata[0].name
}

output "service_node_port" {
  description = "NodePort for accessing the service"
  value       = kubernetes_service.simple_typescript_app.spec[0].port[0].node_port
}

output "replicas" {
  description = "Number of replicas in the deployment"
  value       = kubernetes_deployment.simple_typescript_app.spec[0].replicas
}

output "app_image" {
  description = "Docker image used for the application"
  value       = kubernetes_deployment.simple_typescript_app.spec[0].template[0].spec[0].container[0].image
}

output "access_url" {
  description = "URL to access the application (for Minikube)"
  value       = "http://$(minikube ip):${var.node_port}"
}
