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

resource "mgc_dbaas_clusters" "db_fail" {
  # Argumentos obrigatórios adicionados
  name           = "db-cluster-fail"
  engine_name    = "mysql"
  engine_version = "8.0"
  instance_type  = "DP2-16-40"
  volume_size    = 20
  user           = "testuser"
  password       = "aSecureP@ssw0rd!"

  # Atributo testado
  backup_retention_days = 6 # VIOLAÇÃO
}