resource "helm_release" "this" {
  name       = "fluxcd"
  repository = "https://fluxcd-community.github.io/helm-charts"
  chart      = "flux2"
  namespace  = var.fluxcd_namespace

  version          = var.flux2_chart_version
  create_namespace = var.create_namespace
}
