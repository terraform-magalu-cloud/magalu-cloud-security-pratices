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


resource "mgc_dbaas_instances" "db_fail" {
  # Argumentos obrigatórios adicionados para um 'plan' válido
  name        = "db-fail-instance"
  instance_type = "cloud-dbaas-gp1.small"
  volume_size = 10
  engine_name = "mysql"
  engine_version = "8.0"
  user        = "user"
  password    = "password123!"

  # Argumento sendo testado
  backup_retention_days = 6 # VIOLAÇÃO
}