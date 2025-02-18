module "cloudflared" {
  source = "../../modules/cloudflared"

  cloudflare_account_id  = module.config.cloudflare.account_id
  cloudflare_api_token   = module.config.cloudflare.token
  cloudflare_tunnel_name = "dev"
}
