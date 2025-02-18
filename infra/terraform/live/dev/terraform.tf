terraform {
}

provider "kubernetes" {
  config_path = module.kubernetes.config_path
}
