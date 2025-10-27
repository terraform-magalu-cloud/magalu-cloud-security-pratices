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
  bucket              = "b-fail"
  enable_versioning = false # FAIL
  bucket_is_prefix = "xxxx"
}
resource "mgc_object_storage_buckets" "bucket_fail_implicit" {
  bucket = "b-fail-implicit"
  # enable_versioning is missing # FAIL
  bucket_is_prefix = "xxxx"
}