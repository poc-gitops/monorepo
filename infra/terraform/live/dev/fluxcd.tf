module "fluxcd" {
  source = "../../modules/fluxcd"

  repositories = [
    {
      org  = "poc-gitops"
      name = "monorepo"
      branch = "main"
      deploy_dirs = {
        "dev" = "deploy/fluxcd/dev"
      }
    },
    {
      org  = "poc-gitops"
      name = "web-platform"
      branch = "main"
      deploy_dirs = {
        "dev" = "k8s/dev"
      }
    },
  ]
  github_deploy_key_name = "fluxcd-dev"
}
