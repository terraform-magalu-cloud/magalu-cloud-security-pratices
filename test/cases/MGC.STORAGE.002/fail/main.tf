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

resource "mgc_block_storage_schedule" "sched_fail" {
  name                              = "sched-fail"
  snapshot_type                     = "instant"
  policy_frequency_daily_start_time = "02:00:00"
  policy_retention_in_days          = 3 # FAIL
}