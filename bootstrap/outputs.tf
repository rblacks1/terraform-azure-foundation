output "github_variables" {
  description = "Set these as repository variables in GitHub"
  value = {
    AZURE_CLIENT_ID       = azuread_application.gh_actions.client_id
    AZURE_TENANT_ID       = data.azurerm_client_config.current.tenant_id
    AZURE_SUBSCRIPTION_ID = var.subscription_id
  }
}
