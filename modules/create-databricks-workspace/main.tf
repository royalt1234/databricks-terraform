#####  Create a workspace network #####
resource "databricks_mws_networks" "alpha" {
  provider           = databricks.mws
  account_id         = var.databricks_account_id
  network_name       = "${local.prefix}-network"
  security_group_ids = [aws_security_group.sg.id]
  subnet_ids         = data.aws_subnets.subnet.ids
  vpc_id             = data.aws_vpc.vpc.id
}

#####  Create a root bucket #####
resource "aws_s3_bucket" "root_storage_bucket" {
  bucket        = "${local.prefix}-rootbucket"
  force_destroy = true
  tags = merge(var.tags, {
    Name = "${local.prefix}-rootbucket"
  })
}

resource "aws_s3_bucket_acl" "alpha" {
  bucket = aws_s3_bucket.root_storage_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning_alpha" {
  bucket = aws_s3_bucket.root_storage_bucket.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_public_access_block" "root_storage_bucket" {
  bucket             = aws_s3_bucket.root_storage_bucket.id
  ignore_public_acls = true
  depends_on         = [aws_s3_bucket.root_storage_bucket]
}

data "databricks_aws_bucket_policy" "alpha" {
  bucket = aws_s3_bucket.root_storage_bucket.bucket
}

resource "aws_s3_bucket_policy" "root_bucket_policy" {
  bucket = aws_s3_bucket.root_storage_bucket.id
  policy = data.databricks_aws_bucket_policy.alpha.json
}

resource "databricks_mws_storage_configurations" "alpha" {
  provider                   = databricks.mws
  account_id                 = var.databricks_account_id
  bucket_name                = aws_s3_bucket.root_storage_bucket.bucket
  storage_configuration_name = "${local.prefix}-storage"
}

#### Create a cross-account IAM role ####
data "databricks_aws_assume_role_policy" "alpha" {
  external_id = var.databricks_account_id
}

resource "aws_iam_role" "cross_account_role" {
  name               = "${local.prefix}-crossaccount"
  assume_role_policy = data.databricks_aws_assume_role_policy.alpha.json
  tags               = var.tags
}

data "databricks_aws_crossaccount_policy" "alpha" {}

resource "aws_iam_role_policy" "alpha" {
  name   = "${local.prefix}-policy"
  role   = aws_iam_role.cross_account_role.id
  policy = data.databricks_aws_crossaccount_policy.alpha.json
}

resource "databricks_mws_credentials" "alpha" {
  provider         = databricks.mws
  account_id       = var.databricks_account_id
  role_arn         = aws_iam_role.cross_account_role.arn
  credentials_name = "${local.prefix}-creds"
  depends_on       = [aws_iam_role_policy.alpha]
}

#### Create a Databricks E2 workspace ####
resource "databricks_mws_workspaces" "alpha" {
  provider       = databricks.mws
  account_id     = var.databricks_account_id
  aws_region     = var.region
  workspace_name = local.prefix

  credentials_id           = databricks_mws_credentials.alpha.credentials_id
  storage_configuration_id = databricks_mws_storage_configurations.alpha.storage_configuration_id
  network_id               = databricks_mws_networks.alpha.network_id
}

// export host to be used by other modules
output "databricks_host" {
  value = databricks_mws_workspaces.alpha.workspace_url
}

// create PAT token to provision entities within workspace
# resource "databricks_token" "pat" {
#   provider = databricks.mws
#   comment  = "Terraform Provisioning"
#   // 100 day token
#   lifetime_seconds = 8640000
# }

// output token for other modules
# output "databricks_token" {
#   value     = databricks_token.pat.token_value
#   sensitive = true
# }
