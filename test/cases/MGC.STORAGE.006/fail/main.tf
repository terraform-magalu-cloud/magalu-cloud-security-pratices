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

resource "mgc_object_storage_buckets" "bucket_fail" {
  # Argumento obrigatório adicionado
  bucket           = "bucket-fail-public-read"
  bucket_is_prefix = true

  # Argumento sendo testado
  public_read = true # VIOLAÇÃO
}