locals {
  repos = { for index, r in var.repositories : r.repo => r }
}

resource "kubernetes_manifest" "this" {
  for_each = local.repos

  manifest = {
    apiVersion = "source.toolkit.fluxcd.io/v1beta1"
    kind       = "GitRepository"
    metadata = {
      name      = replace(lower(each.key), "/", "-")
      namespace = var.fluxcd_namespace
      labels = {
        "app.kubernetes.io/managed-by" = "Terraform"
      }
    }
    spec = {
      interval = try(each.value.interval, "1m")
      url      = "ssh://git@github.com/${each.key}.git"
      ref = {
        branch = each.value.branch
      }
      secretRef = {
        name = kubernetes_secret.this.metadata[0].name
      }

      # Exclude all directories and files except the ones specified in deploy_dirs
      # https://fluxcd.io/flux/components/source/gitrepositories/#ignore-spec
      ignore = join("\n", concat(
        ["/* # Exclude all"],
        [for dir in each.value.deploy_dirs : "!/${dir}/**"],
        )
      )
    }
  }
}

resource "github_repository_deploy_key" "this" {
  for_each = local.repos

  title      = var.github_deploy_key_name
  repository = "monorepo"
  key        = tls_private_key.this.public_key_openssh
  read_only  = true
}
