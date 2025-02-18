variable "flux2_chart_version" {
  type    = string
  default = "2.14.1"
}

variable "create_namespace" {
  type    = bool
  default = true
}

variable "fluxcd_namespace" {
  type    = string
  default = "flux-system"
}

variable "repositories" {
  type = list(object({
    repo          = string
    includes      = list(string)
    pull_interval = optional(string, "1m")
    branch        = optional(string, "master")
  }))
  description = "List of repositories to be managed by FluxCD"
}

variable "github_deploy_key_name" {
  type        = string
  description = "Name of the GitHub deploy key to be created"
}
