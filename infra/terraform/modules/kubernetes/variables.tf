variable "cluster_name" {
  description = "The name of the cluster"
  type        = string
}

variable "node_image" {
  description = "The node image to use for the cluster"
  type        = string
  default     = "kindest/node:v1.32.0@sha256:c48c62eac5da28cdadcf560d1d8616cfa6783b58f0d94cf63ad1bf49600cb027"
}

variable "kubeconfig_path" {
  description = "The path to the kubeconfig file"
  type        = string
  default     = null
}
