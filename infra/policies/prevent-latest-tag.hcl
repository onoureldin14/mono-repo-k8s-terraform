policy "prevent-latest-tag" {
  source            = "./policies/prevent-latest-tag.sentinel"
  enforcement_level = "advisory"
}

# This policy can be configured with different enforcement levels:
# - advisory: Shows warnings but allows the plan to proceed
# - soft-mandatory: Requires override to proceed
# - hard-mandatory: Blocks the plan completely

# Note: The tfplan import is automatically provided in Terraform Cloud/Enterprise
# For local testing, use the demo-policy.sentinel file
