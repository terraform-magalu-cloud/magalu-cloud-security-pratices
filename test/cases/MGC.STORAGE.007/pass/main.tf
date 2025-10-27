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

resource "mgc_object_storage_buckets" "bucket_pass" {
  bucket      = "b-pass"
  public_read = true # PASS (Apenas leitura não falha esta regra)
  bucket_is_prefix = true
}
resource "mgc_object_storage_buckets" "bucket_pass_2" {
  bucket  = "b-pass-2"
  private = true # PASS
  bucket_is_prefix = true

}