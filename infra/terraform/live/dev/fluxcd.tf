module "fluxcd" {
  source = "../../modules/fluxcd"

  repositories = [
    {
      repo     = "poc-gitops/monorepo"
      includes = ["deploy", "deploy/fluxcd", "deploy/fluxcd/dev", "deploy/fluxcd/dev/**"]
      branch   = "main"
    },
  ]
  github_deploy_key_name = "fluxcd-dev"
}
