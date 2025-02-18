resource "tls_private_key" "this" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "kubernetes_secret" "this" {
  metadata {
    name      = "github-ssh-keypair"
    namespace = var.fluxcd_namespace
  }

  type = "Opaque"

  data = {
    "identity.pub" = tls_private_key.this.public_key_openssh
    "identity"     = tls_private_key.this.private_key_pem
    "known_hosts"  = "github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg="
  }

  depends_on = [ helm_release.this ]
}
