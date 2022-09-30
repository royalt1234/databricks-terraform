# Create the cluster with the "smallest" amount of resources allowed.
data "databricks_node_type" "smallest" {
  local_disk = true
}

# Use the latest Databricks Runtime Long Term Support (LTS) version.
data "databricks_spark_version" "latest_lts" {
  long_term_support = true
}

resource "databricks_cluster" "this" {
  cluster_name            = var.cluster_name
  node_type_id            = data.databricks_node_type.smallest.id
  spark_version           = data.databricks_spark_version.latest_lts.id
  autotermination_minutes = var.cluster_autotermination_minutes
  num_workers             = var.cluster_num_workers
}

# resource "databricks_cluster" "this-1" {
#   cluster_name            = var.cluster_name-1
#   node_type_id            = data.databricks_node_type.smallest.id
#   spark_version           = data.databricks_spark_version.latest_lts.id
#   autotermination_minutes = var.cluster_autotermination_minutes
#   num_workers             = var.cluster_num_workers
# }

output "cluster_url" {
  value = databricks_cluster.this.url
}

# output "cluster_url-1" {
#  value = databricks_cluster.this-1.url
# }