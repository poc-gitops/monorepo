resource "cloudflare_r2_bucket" "this" {
  account_id    = var.cloudflare_account_id
  name          = "terraform-state-poc-gitops-monorepo"
  storage_class = "Standard"
}
