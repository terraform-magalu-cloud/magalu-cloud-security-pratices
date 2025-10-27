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

resource "mgc_block_storage_volumes" "vol_fail" {
  name      = "vol-fail"
  size      = 10
  type      = "type"
  encrypted = false # FAIL
}
resource "mgc_block_storage_volumes" "vol_fail_implicit" {
  name = "vol-fail-implicit"
  size = 10
  type = "type"
  # encrypted is missing # FAIL
}