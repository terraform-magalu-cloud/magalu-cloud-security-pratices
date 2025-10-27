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

resource "mgc_virtual_machine_instances" "vm_pass" {
  name                     = "vm-pass"
  machine_type             = "BV1-1-40"
  image                    = "cloud-ubuntu-24.04 LTS"
  creation_security_groups = ["sg-123"] # PASS
}