# App Module

This module creates a Kubernetes application that can be deployed as either a **Deployment** or **DaemonSet** based on the `workload_type` variable.

## Features

- ✅ **Conditional Workload Creation**: Creates either Deployment or DaemonSet
- ✅ **Kubernetes Service**: NodePort service for both workload types
- ✅ **Health Checks**: Liveness and readiness probes
- ✅ **Resource Management**: Configurable CPU and memory limits/requests
- ✅ **Environment Variables**: NODE_ENV and PORT configuration
- ✅ **Labels**: Customizable labels for all resources
- ✅ **Namespace Support**: Deploy to any Kubernetes namespace

## Usage

### As a Deployment (default)

```hcl
module "app" {
  source = "./modules/app"

  app_name    = "my-app"
  app_version = "v1.2.3"
  workload_type = "deployment"
  replicas    = 3
}
```

### As a DaemonSet

```hcl
module "app" {
  source = "./modules/app"

  app_name    = "my-app"
  app_version = "v1.2.3"
  workload_type = "daemonset"
  # replicas is ignored for daemonset
}
```

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app_name | Name of the application | `string` | `"simple-typescript-app"` | no |
| app_version | Version tag for the container image | `string` | `"latest"` | no |
| workload_type | Type of workload (deployment or daemonset) | `string` | `"deployment"` | no |
| replicas | Number of replicas (deployment only) | `number` | `2` | no |
| container_port | Port the container listens on | `number` | `3000` | no |
| environment | Environment name | `string` | `"production"` | no |
| resource_limits | Resource limits for containers | `map(string)` | `{cpu="100m", memory="128Mi"}` | no |
| resource_requests | Resource requests for containers | `map(string)` | `{cpu="50m", memory="64Mi"}` | no |
| node_port | Node port for the service | `number` | `30000` | no |
| labels | Additional labels for resources | `map(string)` | `{}` | no |
| namespace | Kubernetes namespace | `string` | `"default"` | no |

## Outputs

| Name | Description |
|------|-------------|
| workload_type | The type of workload created |
| app_name | Name of the application |
| app_image | Container image used |
| service_name | Name of the Kubernetes service |
| service_node_port | Node port for accessing the service |
| access_url | URL to access the application |
| namespace | Kubernetes namespace where resources are created |
| deployment_name | Name of the deployment (if created) |
| daemonset_name | Name of the daemonset (if created) |
| replicas | Number of replicas (deployment only) |

## Examples

### Production Deployment

```hcl
module "app" {
  source = "./modules/app"

  app_name    = "web-app"
  app_version = "v2.1.0"
  workload_type = "deployment"
  replicas    = 5
  
  resource_limits = {
    cpu    = "500m"
    memory = "512Mi"
  }
  
  resource_requests = {
    cpu    = "250m"
    memory = "256Mi"
  }
  
  labels = {
    environment = "production"
    team        = "backend"
  }
  
  namespace = "production"
}
```

### Monitoring DaemonSet

```hcl
module "monitoring" {
  source = "./modules/app"

  app_name    = "node-exporter"
  app_version = "v1.6.0"
  workload_type = "daemonset"
  
  container_port = 9100
  node_port      = 30100
  
  resource_limits = {
    cpu    = "200m"
    memory = "180Mi"
  }
  
  labels = {
    app     = "monitoring"
    service = "node-exporter"
  }
  
  namespace = "monitoring"
}
```

## Notes

- **Replicas**: Only applicable for deployments. DaemonSets run one pod per node automatically.
- **Image**: Uses the format `onoureldin14/{app_name}:{app_version}`
- **Health Checks**: Both liveness and readiness probes check `/health` endpoint
- **Service**: Always creates a NodePort service for external access
