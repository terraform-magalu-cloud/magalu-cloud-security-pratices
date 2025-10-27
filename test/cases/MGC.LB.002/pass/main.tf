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

resource "mgc_lbaas_network" "lb_pass" {
  name       = "lb-pass"
  type       = "proxy"
  visibility = "internal"
  vpc_id     = "vpc-123"
  listeners = [{
    name                 = "https-with-cert"
    port                 = 443
    protocol             = "tls"
    backend_name         = "be"
    tls_certificate_name = "cert-123" # PASS
  }]
  backends = []
}