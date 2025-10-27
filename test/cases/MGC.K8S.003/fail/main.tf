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

resource "mgc_kubernetes_cluster" "k8s_test_fail" { # Renomeado para evitar conflito
  name                 = "k8s-test-fail-affinity"
  version              = "v1.30.2"
  enabled_server_group = false # FAIL
}