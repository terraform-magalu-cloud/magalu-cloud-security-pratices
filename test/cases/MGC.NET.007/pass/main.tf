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

resource "mgc_network_security_groups_rules" "single_port_public" {
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  port_range_min    = 8080 # PASS
  port_range_max    = 8080 # PASS
  security_group_id = "sg-123"
}