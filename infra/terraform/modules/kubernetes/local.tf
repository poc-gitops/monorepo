locals {
  kubeconfig_path = coalesce(var.kubeconfig_path, "/tmp/kubeconfig-${var.cluster_name}")
}
