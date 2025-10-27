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

resource "mgc_kubernetes_cluster" "k8s_test_pass_explicit" { # Renomeado
  name                 = "k8s-test-pass-affinity-explicit"
  version              = "v1.30.2"
  enabled_server_group = true # PASS
}
resource "mgc_kubernetes_cluster" "k8s_test_pass_implicit" { # Renomeado
  name    = "k8s-test-pass-affinity-implicit"
  version = "v1.30.2"
  # enabled_server_group is omitted, defaults to true # PASS
}