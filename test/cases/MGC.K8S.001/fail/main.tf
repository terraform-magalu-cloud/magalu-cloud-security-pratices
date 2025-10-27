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

resource "mgc_kubernetes_cluster" "k8s_fail_no_cidr" {
  name    = "k8s-fail-1"
  version = "v1.30.2"
  # allowed_cidrs is missing # FAIL
}
resource "mgc_kubernetes_cluster" "k8s_fail_open_cidr" {
  name          = "k8s-fail-2"
  version       = "v1.30.2"
  allowed_cidrs = ["0.0.0.0/0"] # FAIL
}