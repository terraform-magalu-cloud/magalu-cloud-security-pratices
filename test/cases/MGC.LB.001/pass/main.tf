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

resource "mgc_lbaas_network" "lb_pass" {
  name       = "lb-pass"
  type       = "proxy"
  visibility = "external"
  vpc_id     = "vpc-123"

  # CORRECTION 1: Added required 'public_ip_id'.
  public_ip_id = "pip-123"

  # CORRECTION 2: Added a tls_certificates block, required for a 'tls' listener.
  # The values for certificate and private_key are dummy base64 strings.
  tls_certificates = [{
    name        = "my-cert"
    certificate = "dGVzdA==" # "test" in base64
    private_key = "dGVzdA==" # "test" in base64
  }]

  listeners = [{
    name         = "https"
    port         = 443
    protocol     = "tls" # PASS
    backend_name = "be"
    
    # CORRECTION 3: Added required 'tls_certificate_name'.
    tls_certificate_name = "my-cert"
  }]

  backends = [{
    name              = "be"
    balance_algorithm = "round_robin"
    targets_type      = "raw"
    targets           = []
  }]
}