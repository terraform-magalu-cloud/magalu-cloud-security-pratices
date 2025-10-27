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

resource "mgc_network_security_groups" "sg_fail" {
  name                  = "sg-fail"
  disable_default_rules = false # FAIL
}
resource "mgc_network_security_groups" "sg_fail_implicit" {
  name = "sg-fail-implicit"
  # disable_default_rules is missing # FAIL
}