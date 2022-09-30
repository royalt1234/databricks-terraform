terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.0.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "databricks" {
  alias    = "mws"
  host     = "https://accounts.cloud.databricks.com"
  username = var.databricks_account_username
  password = var.databricks_account_password
}

# provider "databricks" {
#   host  = var.host
#   token = var.token
# }