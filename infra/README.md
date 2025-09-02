# Infrastructure as Code - Terraform

This directory contains the Terraform configuration for managing the Kubernetes resources for the Simple TypeScript Application.

## Prerequisites

- Terraform >= 1.0
- kubectl configured with access to your cluster
- Docker image built and available in your cluster

## Files

- `main.tf` - Main Terraform configuration with Kubernetes resources
- `variables.tf` - Input variables for customization
- `outputs.tf` - Output values after deployment
- `terraform.tfvars.example` - Example configuration file

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
- `replicas` - Number of deployment replicas (default: 2)
- `container_port` - Container port (default: 3000)
- `node_port` - NodePort for service access (default: 30000)
- `environment` - Environment name (default: "production")
- `resource_limits` - CPU and memory limits
- `resource_requests` - CPU and memory requests

### Customization

Edit `terraform.tfvars` to customize:
- Application name and version
- Number of replicas
- Port configurations
- Resource allocations
- Environment settings

## Resources Created

- **Kubernetes Deployment**: Application pods with health checks
- **Kubernetes Service**: NodePort service for external access

## Health Checks

The deployment includes:
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

Terraform will output:
- Deployment and service names
- NodePort for access
- Number of replicas
- Docker image used
- Access URL for Minikube
