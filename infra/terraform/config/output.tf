locals {
  cloudflare_account_id = "1957884d60695fb1a5fdc25695c5333b"
}

output "cloudflare" {
  value = {
    account_id       = local.cloudflare_account_id
    token            = local.cloudflare_api_token
  }
}
