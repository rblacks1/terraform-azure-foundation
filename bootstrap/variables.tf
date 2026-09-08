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

variable "github_owner_id" {
  type        = string
  description = "Numeric GitHub owner ID, part of the immutable OIDC subject"
}

variable "github_repo_id" {
  type        = string
  description = "Numeric GitHub repository ID, part of the immutable OIDC subject"
}
