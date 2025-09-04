# Infrastructure as Code - Terraform

This directory contains the Terraform configuration for managing the Kubernetes resources for the Simple TypeScript Application.

## Prerequisites

- Terraform >= 1.0
- kubectl configured with access to your cluster
- Docker image built and available in your cluster

## Files

- `main.tf` - Main Terraform configuration using the app module
- `variables.tf` - Input variables for customization
- `outputs.tf` - Output values after deployment
- `terraform.tfvars.example` - Example configuration file
- `modules/app/` - Reusable app module for deployment/daemonset
- `MODULE_USAGE.md` - Detailed module usage guide

## Quick Start

1. **Initialize Terraform**:
   ```bash
   terraform init
   ```

2. **Copy and customize configuration**:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   # Edit terraform.tfvars as needed
   ```

3. **Plan the deployment**:
   ```bash
   terraform plan
   ```

4. **Apply the configuration**:
   ```bash
   terraform apply
   ```

5. **Verify deployment**:
   ```bash
   kubectl get pods
   kubectl get services
   ```

## Configuration

### Variables

- `app_name` - Application name (default: "simple-typescript-app")
- `app_version` - Docker image version (default: "latest")
- `workload_type` - Workload type: "deployment" or "daemonset" (default: "deployment")
- `replicas` - Number of deployment replicas (default: 2, ignored for daemonset)
- `container_port` - Container port (default: 3000)
- `node_port` - NodePort for service access (default: 30000)
- `environment` - Environment name (default: "production")
- `resource_limits` - CPU and memory limits
- `resource_requests` - CPU and memory requests
- `labels` - Additional labels for resources (default: {})
- `namespace` - Kubernetes namespace (default: "default")

### Customization

Edit `terraform.tfvars` to customize:
- Application name and version
- Workload type (deployment or daemonset)
- Number of replicas (deployment only)
- Port configurations
- Resource allocations
- Environment settings
- Labels and namespace

## Resources Created

The infrastructure creates different resources based on the `workload_type`:

**For Deployment (`workload_type = "deployment"`):**
- **Kubernetes Deployment**: Application pods with health checks and specified replicas
- **Kubernetes Service**: NodePort service for external access

**For DaemonSet (`workload_type = "daemonset"`):**
- **Kubernetes DaemonSet**: Application pods running on every node
- **Kubernetes Service**: NodePort service for external access

## Module Usage

This infrastructure uses a flexible app module that can create either a **Deployment** or **DaemonSet** based on the `workload_type` variable.

### Deployment Mode (Default)
```bash
# Creates a Kubernetes Deployment with 2 replicas
terraform plan
terraform apply
```

### DaemonSet Mode
```bash
# Creates a Kubernetes DaemonSet (one pod per node)
terraform plan -var-file=terraform.tfvars.daemonset
terraform apply -var-file=terraform.tfvars.daemonset
```

### Configuration Examples

**Production Deployment:**
```hcl
# terraform.tfvars
app_name = "web-app"
app_version = "v2.1.0"
workload_type = "deployment"
replicas = 5

resource_limits = {
  cpu    = "500m"
  memory = "512Mi"
}

labels = {
  environment = "production"
  team        = "backend"
}
```

**Monitoring DaemonSet:**
```hcl
# terraform.tfvars
app_name = "node-exporter"
app_version = "v1.6.0"
workload_type = "daemonset"
container_port = 9100
node_port = 30100

labels = {
  app     = "monitoring"
  service = "node-exporter"
}
```

For detailed module documentation, see [MODULE_USAGE.md](MODULE_USAGE.md).

## Health Checks

Both deployment and daemonset include:
- **Liveness Probe**: `/health` endpoint every 10 seconds
- **Readiness Probe**: `/health` endpoint every 5 seconds

## Access

After deployment, access the application at:
- **Minikube**: `http://$(minikube ip):30000`
- **Local**: Use `minikube service simple-typescript-app-service`

## Cleanup

To destroy all resources:
```bash
terraform destroy
```

## Outputs

Terraform will output different values based on the workload type:

**For Deployment:**
- `workload_type`: "deployment"
- `deployment_name`: Name of the deployment
- `replicas`: Number of replicas
- `service_name`: Name of the service
- `app_image`: Docker image used
- `access_url`: Access URL for Minikube

**For DaemonSet:**
- `workload_type`: "daemonset"
- `daemonset_name`: Name of the daemonset
- `replicas`: null (not applicable)
- `service_name`: Name of the service
- `app_image`: Docker image used
- `access_url`: Access URL for Minikube
