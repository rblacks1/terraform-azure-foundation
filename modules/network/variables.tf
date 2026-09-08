variable "environment" {
  type        = string
  description = "Environment name, used in resource naming"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group the network is created in"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Address space for the virtual network"
}

variable "subnets" {
  type = map(object({
    address_prefixes = list(string)
  }))
  description = "Subnets to create, keyed by name"
}

variable "tags" {
  type    = map(string)
  default = {}
}
