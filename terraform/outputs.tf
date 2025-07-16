output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "core_cicd_setup" {
  value = module.core_cicd_setup
}

output "vecto_setup_settings" {
  value = var.vecto_setup_settings
}
