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

resource "mgc_network_vpcs_subnets" "subnet_pass" {
  name          = "subnet-pass"
  description   = "Web tier subnet" # PASS
  cidr_block    = "10.0.1.0/24"
  ip_version    = "IPv4"
  subnetpool_id = "sp-123"
  vpc_id        = "vpc-123"
}