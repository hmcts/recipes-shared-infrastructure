
//SHARED VARIABLES
variable "subscription_id" {}
variable "aks_subscription_id" {}

variable "product" {
  description = "The name of your application"
  default     = "recipes"
}

variable "project" {
  default     = "cft"
  description = "Project name"
}

variable "env" {
  description = "The deployment environment (sandbox, aat, prod etc..)"
}

variable "location" {
  description = "The location where you would like to deploy your infrastructure"
  default     = "UK South"
}

variable "team_contact" {
  description = "The name of your Slack channel people can use to contact your team about your infrastructure"
  default     = "#Cloud-Native"
}

variable "common_tags" {
  type = map(string)
}

variable "jenkins_AAD_objectId" {
  description = "This is the ID of the Application you wish to give access to the Key Vault via the access policy"
}


# APP INSIGHTS SPECIFIC VARIABLES
variable "appinsights_location" {
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  default     = "UK South"
}

variable "application_type" {
  description = "This is the type of application you are creating app insights. Valid values are Web and Other"
  default     = "web"
}

variable "daily_data_cap_in_gb" {
  description = "Specifies the Application Insights component daily data volume cap in GB"
  default     = 100
}

# KEY VAULT SPECIFIC VARIABLES
variable "tenant_id" {
  description = "The Tenant ID of the Azure Active Directory"
}

variable "managed_identity_object_id" {
  default = ""
}

variable "additional_managed_identities_access" {
  type    = list(string)
  default = []
}

# REDIS
variable "rdb_backup_enabled" {
  type    = bool
  default = false
}

variable "sku_name" {
  default     = "Basic"
  description = "The SKU of Redis to use. Possible values are `Basic`, `Standard` and `Premium`."
}

variable "family" {
  default     = "C"
  description = "The SKU family/pricing group to use. Valid values are `C` (for Basic/Standard SKU family) and `P` (for Premium). Use P for higher availability, but beware it costs a lot more."
}

variable "redis_capacity" {
  default     = "1"
  description = "The size of the Redis cache to deploy. Valid values are 1, 2, 3, 4, 5"
}

variable "redis_backup_frequency" {
  default     = "360"
  description = "The Backup Frequency in Minutes. Only supported on Premium SKUs. Possible values are: 15, 30, 60, 360, 720 and 1440"
}

variable "rdb_backup_max_snapshot_count" {
  type    = string
  default = "1"
}

# Postgres

variable "pgsql_sku" {
  default = "GP_Standard_D2s_v3"
}


# API Management

# thumbprint of the SSL certificate for API gateway tests
variable "api_gateway_test_certificate_thumbprint" {
  # keeping this empty by default, so that no thumbprint will match
  default = ""
}
