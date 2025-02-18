terraform {
  required_providers {
    github = {
      source = "integrations/github"
    }
  }
}

provider "kubernetes" {
  config_path = module.kubernetes.config_path
}

provider "helm" {
  kubernetes {
    config_path = module.kubernetes.config_path
  }
}

provider "github" {
  owner = "poc-gitops"

  app_auth {
    id              = "1149846"
    installation_id = "61276180"
    pem_file        = file("${path.module}/credentials/demo-gitops.gh-app.pem")
  }
}
