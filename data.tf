### VPC #####

data "aws_vpc" "vpc" {
  id = var.vpc_id
}

data "aws_subnets" "subnet" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}

###this is for the manage databricks workspace and should only be uncommented after the workspace is create and you want to run the manage databricks workspace module ###
# data "databricks_current_user" "me" {
#   depends_on = [databricks_mws_workspaces.alpha]
# }