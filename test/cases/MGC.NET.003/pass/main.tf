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

resource "mgc_network_security_groups_rules" "ssh_restricted_ipv6" {
  direction         = "ingress"
  ethertype         = "IPv6"
  protocol          = "tcp"
  remote_ip_prefix  = "2001:db8::/32" # CORRETO: Acesso restrito a uma sub-rede IPv6.
  port_range_min    = 22
  port_range_max    = 22
  security_group_id = "sg-123"
}