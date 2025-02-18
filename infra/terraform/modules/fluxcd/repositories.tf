locals {
  repos = { for index, r in var.repositories :
    # Normalize the org-repository to be used as k8s resource name
    replace(lower("${r.org}-${r.name}"), "_", "-") => r
  }

  common_labels = {
    "app.kubernetes.io/managed-by" = "Terraform"
  }
}

resource "github_repository_deploy_key" "this" {
  for_each = local.repos

  title      = var.github_deploy_key_name
  repository = each.value.name
  key        = tls_private_key.this.public_key_openssh
  read_only  = true
}

resource "kubernetes_manifest" "repository" {
  for_each = local.repos

  field_manager {
    force_conflicts = true
  }

  manifest = {
    apiVersion = "source.toolkit.fluxcd.io/v1beta1"
    kind       = "GitRepository"
    metadata = {
      name      = each.key
      namespace = var.fluxcd_namespace
      labels    = local.common_labels
    }
    spec = {
      interval = try(each.value.interval, "1m")
      url      = "ssh://git@github.com/${each.value.org}/${each.value.name}.git"
      ref = {
        branch = each.value.branch
      }
      secretRef = {
        name = kubernetes_secret.this.metadata[0].name
      }
    }
  }
}

resource "kubernetes_manifest" "kustomization" {
  for_each = merge([
    for rname, repo_config in local.repos : {
      for deploy_name, dir in repo_config.deploy_dirs :
      "${rname}-${deploy_name}" => {
        repo = rname
        dir  = dir
      }
    }
  ]...)

  field_manager {
    force_conflicts = true
  }

  manifest = {
    apiVersion = "kustomize.toolkit.fluxcd.io/v1"
    kind       = "Kustomization"
    metadata = {
      name      = each.key
      namespace = var.fluxcd_namespace
      labels    = local.common_labels
    }
    spec = {
      interval = try(each.value.interval, "1m")
      sourceRef = {
        kind = "GitRepository"
        name = each.value.repo
      }
      path  = each.value.dir
      prune = true
    }
  }
}
