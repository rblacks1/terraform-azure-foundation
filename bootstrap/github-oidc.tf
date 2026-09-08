data "azuread_client_config" "current" {}

resource "azuread_application" "gh_actions" {
  display_name = "gh-actions-terraform"
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "gh_actions" {
  client_id = azuread_application.gh_actions.client_id
  owners    = [data.azuread_client_config.current.object_id]
}

# One credential per context. Subjects are matched on an exact string,
# so there is no wildcarding your way out of this.
locals {
  federated_subjects = {
    "gh-pull-request" = "repo:${var.github_org}/${var.github_repo}:pull_request"
    "gh-env-dev"      = "repo:${var.github_org}/${var.github_repo}:environment:dev"
    "gh-env-prod"     = "repo:${var.github_org}/${var.github_repo}:environment:prod"
  }
}

resource "azuread_application_federated_identity_credential" "gh" {
  for_each = local.federated_subjects

  application_id = azuread_application.gh_actions.id
  display_name   = each.key
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = each.value
  audiences      = ["api://AzureADTokenExchange"]
}

resource "azurerm_role_assignment" "gh_contributor" {
  scope                            = "/subscriptions/${var.subscription_id}"
  role_definition_name             = "Contributor"
  principal_id                     = azuread_service_principal.gh_actions.object_id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "gh_blob_contributor" {
  scope                            = azurerm_storage_account.tfstate.id
  role_definition_name             = "Storage Blob Data Contributor"
  principal_id                     = azuread_service_principal.gh_actions.object_id
  skip_service_principal_aad_check = true
}
