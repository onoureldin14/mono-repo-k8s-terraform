# Terraform Policies

This directory contains Terraform policies to enforce best practices and security standards in your infrastructure code.

## ⚠️ Important: Sentinel Usage Limitations

**Sentinel policies require Terraform Cloud/Enterprise for full functionality.** The `tfplan` import is not available in local Sentinel CLI, which means:

- ✅ **Terraform Cloud/Enterprise**: Full integration, automatic policy enforcement
- ❌ **Local Sentinel CLI**: Limited to testing policy logic with mock data only
- 🔄 **Local Workflows**: Consider using OPA (Open Policy Agent) instead for local plan validation

**For local development**, the demo policies in this directory show how the logic works, but they cannot validate actual Terraform plans without Terraform Cloud/Enterprise.

## Available Policies

### prevent-latest-tag

**Purpose**: Prevents the use of the "latest" tag for container images in Kubernetes deployments.

**Why this matters**:
- Using "latest" tag makes deployments unpredictable and harder to rollback
- It can lead to unexpected behavior when new versions are pushed to the registry
- Makes it difficult to track which version is actually running in production
- Can cause issues with caching and image pulls

**What it checks**:
- Kubernetes Deployments (the main workload type used in this project)

**Enforcement Level**: Advisory (shows warnings but allows deployment)

## Usage

### With Terraform Cloud/Enterprise

1. Upload the policy files to your Terraform Cloud workspace
2. Configure the policy set to include these policies
3. The policies will run automatically on plan and apply operations

### With Local Sentinel CLI

#### Installation

**macOS (using Homebrew):**
```bash
brew install hashicorp/tap/sentinel
```

**Linux/Windows:**

Install Sentinel CLI [HashiCorp's releases page](https://developer.hashicorp.com/terraform/tutorials/policy/sentinel-install)

**Verify installation:**
```bash
sentinel version
```

#### Testing Locally

**Note**: The `tfplan` import is only available in Terraform Cloud/Enterprise. For local testing, we use demo policies to verify the logic.

1. **Install Sentinel:**
```bash
# macOS
brew install hashicorp/tap/sentinel

# Verify installation
sentinel version
```

2. **Navigate to the project root:**
```bash
cd /path/to/your/project
```

3. **Test the policy logic:**
```bash
# Test with compliant scenario (should PASS)
sentinel apply policies/demo-policy.sentinel

# Test with non-compliant scenario (should FAIL)
sentinel apply policies/test-policy.sentinel
```

**Expected Results:**
- `demo-policy.sentinel` → **Pass** (uses versioned image)
- `test-policy.sentinel` → **Fail** (uses "latest" tag)

#### Testing with Different Scenarios

**Test with a compliant configuration (current setup):**
Your current `main.tf` uses `var.app_version` which should be set to a specific version, so it should pass the policy.

**Test with a non-compliant configuration:**
Temporarily modify your `main.tf` to use "latest" tag:
```bash
# Create a test version of main.tf
cp main.tf main.tf.backup
sed -i '' 's/:${var.app_version}/:latest/g' main.tf

# Run the policy
terraform plan -out=plan.out
sentinel apply -config=./policies/prevent-latest-tag.hcl plan.out

# Restore original file
mv main.tf.backup main.tf
rm plan.out
```

#### Expected Output

**When policy passes:**
```
Pass - prevent-latest-tag.sentinel
```

**When policy fails:**
```
Fail - prevent-latest-tag.sentinel

prevent-latest-tag.sentinel:1:1 - Rule "main"
  Value: false
```

#### Troubleshooting

**If you get "plan.out not found":**
- Make sure you're in the `infra` directory when running `terraform plan`
- Check that the plan file was created: `ls -la plan.out`

**If you get "config file not found":**
- Make sure you're running the sentinel command from the `infra` directory
- Verify the path to the config file: `../policies/prevent-latest-tag.hcl`

**If you get "no tfplan import":**
- Make sure you're using the correct Sentinel version (0.18.0+)
- The tfplan import is available in newer versions of Sentinel

#### Quick Test

To quickly verify the policy is working:

```bash
# Install Sentinel (macOS)
brew install hashicorp/tap/sentinel

# Test the policy
cd /path/to/your/project
sentinel apply policies/demo-policy.sentinel
```

**Expected Result:** `Pass - demo-policy.sentinel` (uses versioned image `nginx:1.21.6`)

### With OPA (Open Policy Agent)

If you prefer using OPA instead of Sentinel, you can convert these policies to Rego format.

## Configuration

You can modify the enforcement level in the `.hcl` configuration files:

- `advisory`: Shows warnings but allows the plan to proceed
- `soft-mandatory`: Requires override to proceed  
- `hard-mandatory`: Blocks the plan completely

## Example

The policy checks your Kubernetes deployment configuration. Here's how it works:

**❌ This will trigger the policy (using "latest" tag):**
```hcl
resource "kubernetes_deployment" "example" {
  spec {
    template {
      spec {
        container {
          name  = "app"
          image = "nginx:latest"  # Policy will fail here
        }
      }
    }
  }
}
```

**✅ This will pass the policy (using specific version):**
```hcl
resource "kubernetes_deployment" "example" {
  spec {
    template {
      spec {
        container {
          name  = "app"
          image = "nginx:1.21.6"  # Policy will pass here
        }
      }
    }
  }
}
```

## Adding New Policies

To add a new policy:

1. Create a new `.sentinel` file with your policy logic
2. Create a corresponding `.hcl` configuration file
3. Update this README with documentation
4. Test the policy with sample Terraform configurations

## Best Practices

- Use semantic versioning for container images (e.g., `v1.2.3`)
- Pin to specific versions in production environments
- Use digest-based references for maximum security (e.g., `nginx@sha256:...`)
- Consider using image scanning tools in your CI/CD pipeline
