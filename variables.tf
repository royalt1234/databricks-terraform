### Create databricks workspace ###
variable "vpc_id" {}

variable "databricks_account_username" {
  type        = string
  description = "the account username of your databricks account (this is the email address)"
}

variable "databricks_account_password" {
  type        = string
  description = "password of your databricks account"
}

variable "databricks_account_id" {
  type        = string
  description = "account id of your databricks account"
}

variable "tags" {
  default = {}
}

variable "region" {
  type = string
}

resource "random_string" "naming" {
  special = false
  upper   = false
  length  = 6
}

locals {
  prefix = "alpha${random_string.naming.result}"
}

#### manage databricks workspace #####
# variable "host" {
#   type        = string
#   description = "the url of the workspace you want to create resources in or manage"
# }

# variable "token" {
#   type        = string
#   description = "the access token created from the workspace to be used. You can either output this from the module that create the workspace or just create it and input on the terraform.tfvars"
# }

# variable "cluster_name" {
#   description = "A name for the cluster."
#   type        = string
# }

# variable "cluster_name-1" {
#   description = "A name for the second cluster. Overtime, this would/should be refactored to use a count index"
#   type        = string
# }

# variable "cluster_autotermination_minutes" {
#   description = "How many minutes before automatically terminating due to inactivity."
#   type        = number
# }

# variable "cluster_num_workers" {
#   description = "The number of workers."
#   type        = number
#   default     = 1
# }

# variable "cluster_num_workers-1" {
#   description = "The number of workers."
#   type        = number
#   default     = 1
# }

# variable "num_workers_task-1" {
#   type        = number
#   description = "number of workers"
# }

# variable "job_name" {
#   description = "A name for the job."
#   type        = string
# }

# variable "multiple_job_name" {
#   description = "A name for the job that runs multiple tasks."
#   type        = string
# }

# variable "num_workers" {
#   type        = number
#   description = "number of workers"
# }

# variable "notebook_subdirectory" {
#   description = "A name for the subdirectory to store the notebook."
#   type        = string
#   default     = "Terraform"
# }

# variable "notebook_filename" {
#   description = "The notebook's filename."
#   type        = string
# }

# variable "notebook_language" {
#   description = "The language of the notebook."
#   type        = string
# }

# variable "pipeline_name" {
#   type        = string
#   description = "name of pipeline"
# }

# variable "git_username" {
#   type        = string
#   description = "username for the git repo"
# }

# variable "git_provider" {
#   type        = string
#   description = "the provider, gitHub in this case. Note its case sensitive"
# }

# variable "personal_access_token" {
#   type        = string
#   description = "PATs for the git repo"
# }

# variable "repo_url" {
#   type        = string
#   description = "the url of the repo that contains the data to be ETLed"
# }