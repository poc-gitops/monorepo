module "fluxcd" {
  source = "../../modules/fluxcd"

  repositories = [
    {
      repo        = "poc-gitops/monorepo"
      deploy_dirs = ["deploy/fluxcd/dev"]
      branch      = "main"
    },
  ]
  github_deploy_key_name = "fluxcd-dev"
}
