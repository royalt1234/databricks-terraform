##### create databricks workspace ####
module "create-databricks-workspace" {
  source                      = "./modules/create-databricks-workspace"
  databricks_host = module.create-databricks-workspace.databricks_host
  region                      = var.region
  databricks_account_username = var.databricks_account_username
  databricks_account_password = var.databricks_account_password
  databricks_account_id       = var.databricks_account_id
  vpc_id                      = var.vpc_id
}

##### manage databricks workspace ####
# module "manageWS" {
#   source = "./modules/manage-databricks-workspace"
#   # host                            = var.host
#   # token                           = var.token
#   cluster_name                    = var.cluster_name
#   cluster_name-1                  = var.cluster_name-1
#   cluster_autotermination_minutes = var.cluster_autotermination_minutes
#   num_workers                     = var.num_workers
#   num_workers_task-1              = var.num_workers_task-1
#   git_username                    = var.git_username
#   git_provider                    = var.git_provider
#   personal_access_token           = var.personal_access_token
#   repo_url                        = var.repo_url
#   job_name                        = var.job_name
#   notebook_language               = var.notebook_language
#   notebook_filename               = var.notebook_filename
#   multiple_job_name               = var.multiple_job_name
#   pipeline_name                   = var.pipeline_name
#   path                            = "${data.databricks_current_user.me.home}/${var.notebook_subdirectory}/${var.notebook_filename}"
# }