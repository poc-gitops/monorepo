resource "kubernetes_namespace" "this" {
  metadata {
    name = "cloudflared"
  }
}

resource "kubernetes_secret" "this" {
  metadata {
    name      = "cloudflare"
    namespace = kubernetes_namespace.this.metadata.0.name
  }

  data = {
    account_id  = var.cloudflare_account_id
    tunnel_name = var.cloudflare_tunnel_name
    api_token   = var.cloudflare_api_token
  }
}
