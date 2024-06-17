# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform and OpenTofu that helps keep your code DRY and
# maintainable: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

# Include the root `terragrunt.hcl` configuration. The root configuration contains settings that are common across all
# components and environments, such as how to configure remote state.
include "root" {
  path = find_in_parent_folders()
}

# Include the envcommon configuration for the component. The envcommon configuration contains settings that are common
# for the component across all environments.
include "envcommon" {
  path   = "${dirname(find_in_parent_folders())}/_envcommon/argo.hcl"
  # We want to reference the variables from the included config in this configuration, so we expose it.
  expose = true
}

# Configure the version of the module to use in this environment. This allows you to promote new versions one
# environment at a time (e.g., qa -> stage -> prod).
terraform {
  source = "${include.envcommon.locals.base_source_url}?ref=v0.1.1--argo"
}

// dependency "eks" {
//   config_path = "../eks"
//   skip_outputs = true
//   // mock_outputs = {
//   //   vpc_id          = "vpc-0d92a29a969c4f59d"
//   // }
//   // mock_outputs_allowed_terraform_commands = ["plan"]

// }

// # ---------------------------------------------------------------------------------------------------------------------
// # We don't need to override any of the common parameters for this environment, so we don't specify any inputs.
// # ---------------------------------------------------------------------------------------------------------------------
// inputs = {
//   cluster_certificate_authority_data = base64decode(dependency.eks.cluster_certificate_authority_data)
//   cluster_endpoint                   = dependency.eks.cluster_endpoint
//   cluster_name                       = dependency.eks.cluster_name
// }

