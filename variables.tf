variable "app_metadata" {
  description = <<EOF
Nullstone automatically injects metadata from the app module into this module through this variable.
This variable is a reserved variable for capabilities.
EOF

  type    = map(string)
  default = {}
}

variable "database_name" {
  type        = string
  description = <<EOF
Name of database to create in Mysql cluster. If left blank, uses app name.
The following identifiers are supported for interpolation:
  {{ NULLSTONE_STACK }}
  {{ NULLSTONE_BLOCK }}
  {{ NULLSTONE_ENV }}
EOF
  default     = ""
}

// We are using ns_env_variables to interpolate database_name
data "ns_env_variables" "db_name" {
  input_env_variables = tomap({
    NULLSTONE_STACK = local.stack_name
    NULLSTONE_APP   = local.block_name
    NULLSTONE_ENV   = local.env_name
    DATABASE_NAME   = coalesce(var.database_name, local.block_name)
  })
  input_secrets = tomap({})
}

locals {
  security_group_id = var.app_metadata["security_group_id"]
  username          = local.resource_name
  database_name     = data.ns_env_variables.db_name.env_variables["DATABASE_NAME"]
}
