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

resource "mgc_kubernetes_nodepool" "nodepool_fail" {
  name               = "np-fail"
  cluster_id         = "k8s-123"
  flavor_name        = "flavor"
  replicas           = 2
  availability_zones = ["br-se1-a"] # FAIL
}