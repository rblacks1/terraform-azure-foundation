variable "subscription_id" {
  type        = string
  description = "Target Azure subscription"
}

variable "storage_account_name" {
  type        = string
  description = "Globally unique, 3 to 24 chars, lowercase alphanumeric"
}

variable "github_org" {
  type        = string
  description = "GitHub account or organisation that owns the repo"
}

variable "github_repo" {
  type        = string
  description = "Repository name, used to build OIDC subject strings"
}
