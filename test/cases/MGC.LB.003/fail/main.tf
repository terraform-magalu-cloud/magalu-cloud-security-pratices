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

resource "mgc_lbaas_network" "lb_fail" {
  name       = "lb-fail"
  type       = "proxy"
  visibility = "internal"
  vpc_id     = "vpc-123"
  listeners  = []
  backends = [{
    name              = "be-no-hc"
    balance_algorithm = "round_robin"
    targets_type      = "raw"
    targets           = []
    # health_check_name is missing # FAIL
  }]
}