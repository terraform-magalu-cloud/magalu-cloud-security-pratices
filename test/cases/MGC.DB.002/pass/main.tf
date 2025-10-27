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

resource "mgc_dbaas_clusters" "db_pass" {
  name                  = "test"
  engine_name           = "mysql"
  engine_version        = "8.0"
  instance_type         = "type"
  volume_size           = 10
  backup_retention_days = 8 # PASS
  user = "xpto"
  password = "xxxxpto123"
}