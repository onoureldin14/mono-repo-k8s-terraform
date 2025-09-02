# Infrastructure Deployment

This directory contains the GitHub Actions workflow for deploying the application to Minikube.

## Workflow

### Deploy to Minikube (`deploy.yml`)
**Triggers:** After Docker image is built and pushed

**What it does:**
1. Sets up Minikube cluster on GitHub Actions
2. Deploys the application using Terraform
3. Waits for pods to be ready
4. Shows deployment status and access URL

## How it works

1. **App pipeline** builds and pushes Docker image to `onoureldin14/simple-typescript-app:latest`
2. **Infra pipeline** automatically deploys to Minikube using Terraform
3. **Result**: Application running on Minikube cluster

## Access

After deployment, the application will be accessible at:
- **URL**: `http://{minikube-ip}:30000`
- **Health check**: `http://{minikube-ip}:30000/health`
- **API info**: `http://{minikube-ip}:30000/api/info`

## Requirements

- Terraform configuration in `infra/` folder
- Docker image available at `onoureldin14/simple-typescript-app:latest`
- GitHub Actions secrets for Docker Hub access
