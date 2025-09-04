output "workload_type" {
  description = "The type of workload created (deployment or daemonset)"
  value       = module.app.workload_type
}

output "deployment_name" {
  description = "Name of the Kubernetes deployment (if created)"
  value       = module.app.deployment_name
}

output "daemonset_name" {
  description = "Name of the Kubernetes daemonset (if created)"
  value       = module.app.daemonset_name
}

output "service_name" {
  description = "Name of the Kubernetes service"
  value       = module.app.service_name
}

output "service_node_port" {
  description = "NodePort for accessing the service"
  value       = module.app.service_node_port
}

output "replicas" {
  description = "Number of replicas in the deployment (only applicable for deployments)"
  value       = module.app.replicas
}

output "app_image" {
  description = "Docker image used for the application"
  value       = module.app.app_image
}

output "access_url" {
  description = "URL to access the application (for Minikube)"
  value       = module.app.access_url
}

output "namespace" {
  description = "Kubernetes namespace where resources are created"
  value       = module.app.namespace
}
