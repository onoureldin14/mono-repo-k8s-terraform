# Main CI/CD Pipeline

This is the main pipeline that orchestrates the entire CI/CD process for the Simple TypeScript Application.

## Overview

The main pipeline combines both application building and infrastructure deployment into a single workflow, providing a unified CI/CD experience.

## Workflow

### Main CI/CD Pipeline (`main-pipeline.yml`)

**Triggers:**
- Push to `main` branch
- Pull requests to `main` branch
- Manual trigger (`workflow_dispatch`)

**Jobs:**

1. **`build-app`** - Builds and pushes the Docker image
   - Sets up Node.js environment
   - Installs dependencies and builds TypeScript app
   - Builds and pushes Docker image to `onoureldin14/simple-typescript-app:latest`

2. **`deploy-infra`** - Deploys to Minikube using Terraform
   - Sets up Minikube cluster
   - Deploys infrastructure using Terraform
   - Waits for pods to be ready
   - Shows deployment status and access URLs

3. **`summary`** - Provides overall pipeline status
   - Reports success/failure for each stage
   - Shows final status of the entire pipeline

## Flow

```
Push to main branch
       ↓
   build-app job
       ↓
   deploy-infra job
       ↓
    summary job
```

## Benefits

- **Single entry point** for the entire CI/CD process
- **Sequential execution** ensures proper order of operations
- **Unified status reporting** for the complete pipeline
- **Automatic deployment** after successful build
- **Manual trigger capability** for testing and debugging

## Access

After successful deployment, your application will be accessible at:
- **Main URL**: `http://{minikube-ip}:30000`
- **Health Check**: `http://{minikube-ip}:30000/health`
- **API Info**: `http://{minikube-ip}:30000/api/info`

## Manual Trigger

You can manually trigger this pipeline from the GitHub Actions tab:
1. Go to Actions → Main CI/CD Pipeline
2. Click "Run workflow"
3. Select branch and click "Run workflow"

## Requirements

- GitHub secrets: `DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN`
- Terraform configuration in `infra/` folder
- Application code in `app/` folder
