# Mono-Repo Kubernetes Terraform Example

A complete example project demonstrating modern CI/CD practices with TypeScript, Docker, Kubernetes, and Terraform.

## 🏗️ Project Structure

```
mono-repo-k8s-terraform/
├── .github/workflows/
│   └── main-pipeline.yml          # Main CI/CD pipeline
├── app/                           # Application code
│   ├── .github/workflows/
│   │   └── docker-build-push.yml # App build pipeline
│   ├── src/
│   │   └── index.ts              # TypeScript application
│   ├── Dockerfile                 # Docker build
│   └── package.json               # App dependencies
└── infra/                         # Infrastructure (Terraform)
    ├── .github/workflows/
    │   └── deploy.yml             # Infrastructure deployment
    ├── main.tf                    # Terraform configuration
    ├── variables.tf               # Terraform variables
    └── outputs.tf                 # Terraform outputs
```

## 🚀 Quick Start

### Prerequisites
- GitHub repository with Actions enabled
- Docker Hub account (`onoureldin14`)
- GitHub secrets configured

### Setup
1. **Configure GitHub Secrets**:
   - `DOCKERHUB_USERNAME`: Your Docker Hub username
   - `DOCKERHUB_TOKEN`: Your Docker Hub access token

2. **Push to main branch**:
   - Triggers the main CI/CD pipeline
   - Builds Docker image and deploys to Minikube

## 🔄 CI/CD Pipeline

### Main Pipeline (`.github/workflows/main-pipeline.yml`)
**Single entry point** that orchestrates the entire process:

1. **Build App** → TypeScript build + Docker image creation
2. **Deploy Infra** → Minikube setup + Terraform deployment
3. **Summary** → Overall pipeline status

### Individual Pipelines
- **App Pipeline**: Builds and pushes Docker images
- **Infra Pipeline**: Deploys to Minikube using Terraform

## 🐳 Docker Images

Images are automatically built and pushed to:
- **Registry**: `onoureldin14/simple-typescript-app`
- **Tag**: `latest` (on main branch)
- **Multi-platform**: Linux AMD64 and ARM64

## ☸️ Kubernetes Deployment

### Resources Created
- **Deployment**: 2 replicas with health checks
- **Service**: NodePort service on port 30000
- **Health Probes**: Liveness and readiness checks

### Access
After deployment, your application is accessible at:
- **Main URL**: `http://{minikube-ip}:30000`
- **Health Check**: `http://{minikube-ip}:30000/health`
- **API Info**: `http://{minikube-ip}:30000/api/info`

## 🛠️ Local Development

### App Development
```bash
cd app
npm install
npm run dev          # Development mode
npm run build        # Build for production
npm run docker:build # Build Docker image locally
npm run docker:run   # Run Docker container locally
```

### Infrastructure
```bash
cd infra
terraform init
terraform plan
terraform apply
```

## 📚 API Endpoints

- `GET /` - Application information
- `GET /health` - Health check for Kubernetes
- `GET /api/info` - Detailed system information

## 🔧 Customization

### Application
- Modify `app/src/index.ts` for application logic
- Update `app/package.json` for dependencies
- Customize `app/Dockerfile` for containerization

### Infrastructure
- Edit `infra/variables.tf` for configuration
- Modify `infra/main.tf` for Kubernetes resources
- Update `infra/terraform.tfvars.example` for values

## 🚨 Troubleshooting

### Common Issues
1. **Docker build fails**: Check Dockerfile syntax and dependencies
2. **Terraform fails**: Verify Kubernetes cluster access and configuration
3. **Pods not ready**: Check health check endpoints and resource limits

### Debug Commands
```bash
# Check pod status
kubectl get pods
kubectl describe pods

# Check logs
kubectl logs -l app=simple-typescript-app

# Check services
kubectl get services
```

## 📖 Learn More

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Terraform Kubernetes Provider](https://registry.terraform.io/providers/hashicorp/kubernetes)
- [Minikube Documentation](https://minikube.sigs.k8s.io/docs/)
- [Docker Multi-stage Builds](https://docs.docker.com/develop/dev-best-practices/dockerfile_best-practices/)

## 🤝 Contributing

This is an example project demonstrating modern DevOps practices. Feel free to:
- Fork and modify for your own projects
- Submit issues for improvements
- Create pull requests for enhancements

## 📄 License

MIT License - feel free to use this project as a starting point for your own applications.
