# ---------------------------------------------------------------------------------------------------------------------
# ¦ REQUIREMENTS
# ---------------------------------------------------------------------------------------------------------------------
terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source                = "hashicorp/aws"
      configuration_aliases = []
    }
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = ">= 0.9.0"
    }
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# ¦ LOCALS
# ---------------------------------------------------------------------------------------------------------------------
# Build the Azure DevOps organization service URL from the organization name
locals {
  ado_org_service_url = "https://dev.azure.com/${var.vecto_setup_settings.ado_settings.organization_name}/"
}

# ---------------------------------------------------------------------------------------------------------------------
# ¦ PROVIDER
# ---------------------------------------------------------------------------------------------------------------------
provider "aws" {
  region = "eu-central-1"
}

provider "azuredevops" {
  org_service_url = local.ado_org_service_url
}

# ---------------------------------------------------------------------------------------------------------------------
# ¦ DATA
# ---------------------------------------------------------------------------------------------------------------------
data "aws_caller_identity" "current" {}

# ---------------------------------------------------------------------------------------------------------------------
# ¦ CORE_CICD_SETUP
# ---------------------------------------------------------------------------------------------------------------------
module "core_cicd_setup" {
  source = "git::https://github.com/acai-consulting/terraform-aws-acf-ado-core-cicd.git//10-setup/ado-oidc?ref=oidc_support"

  aws_settings        = var.vecto_setup_settings.aws_settings
  ado_settings        = var.ado_settings
  vecto_repo_settings = var.vecto_repo_settings

  resource_tags = {}
}

