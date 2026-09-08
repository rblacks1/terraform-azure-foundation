resource "azurerm_resource_group" "platform" {
  name     = "rg-platform-${var.environment}-uks"
  location = var.location

  tags = local.tags
}

locals {
  tags = {
    environment = var.environment
    managed_by  = "terraform"
    project     = "terraform-azure-foundation"
  }
}

module "network" {
  source = "../../modules/network"

  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name
  vnet_address_space  = ["10.10.0.0/16"]

  subnets = {
    # /20 because project 2 puts AKS node pools here and they need room
    "snet-aks" = { address_prefixes = ["10.10.0.0/20"] }
    "snet-app" = { address_prefixes = ["10.10.16.0/24"] }
    "snet-pe"  = { address_prefixes = ["10.10.17.0/24"] }
  }

  tags = local.tags
}
