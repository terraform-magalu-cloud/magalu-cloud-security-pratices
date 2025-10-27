terraform {
  required_providers {
    mgc = {
      source  = "MagaluCloud/mgc"
      version = ">= 0.39.0" # Use a versão relevante
    }
  }
}

provider "mgc" {
api_key = var.api_key
region = var.region
}

variable "api_key" {
    description = "API Key para autenticação no Magalu Cloud"
    type = string
    default = ""
}

variable "region" {
    description = "Região do Magalu Cloud"
    type = string
    default = ""
}

resource "mgc_kubernetes_nodepool" "nodepool_pass" {
  name        = "np-pass"
  cluster_id  = "k8s-123"
  flavor_name = "flavor"
  replicas    = 3
  min_replicas = 2 # PASS
  max_replicas = 5 # PASS
}