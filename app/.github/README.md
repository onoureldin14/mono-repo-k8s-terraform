# GitHub Actions - Simple Docker Build

This directory contains a minimal GitHub Actions workflow for building and pushing Docker images.

## Workflow

### Docker Build and Push (`docker-build-push.yml`)
**Triggers:** Push to main branch, Pull Requests

**What it does:**
- Builds Docker image on every push/PR
- Pushes to `onoureldin14/simple-typescript-app:latest` on main branch
- Only builds (no push) on Pull Requests

## Docker Registry

Images are pushed to: `onoureldin14/simple-typescript-app:latest`

## Required Secrets

Set these secrets in your GitHub repository:

- `DOCKERHUB_USERNAME`: Your Docker Hub username
- `DOCKERHUB_TOKEN`: Your Docker Hub access token

## Usage

1. Push to `main` branch → Image automatically built and pushed
2. Create PR → Image built for testing (not pushed)
3. Use `onoureldin14/simple-typescript-app:latest` in your Kubernetes deployment

## Local Testing

```bash
# Build locally
npm run docker:build

# Run locally
npm run docker:run
```
