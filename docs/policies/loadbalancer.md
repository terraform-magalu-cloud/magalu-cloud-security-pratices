# Loadbalancer Policies

## MGC.LB.001: Ensure external Load Balancers use TLS (HTTPS)

**Severity:** !!! danger "HIGH"

**Category:** `Load Balancer`

**Description:**
Detects Load Balancers ('mgc_lbaas_network') with 'visibility = external' that do not have any 'tls' listener configured.

**Source Code:** [mgc_lb_ensure_external_uses_tls.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/loadbalancer/mgc_lb_ensure_external_uses_tls.rego)
---

## MGC.LB.002: Ensure TLS listeners have an associated certificate

**Severity:** !!! warning "MEDIUM"

**Category:** `Load Balancer`

**Description:**
Detects listeners ('mgc_lbaas_network.listeners') with 'protocol = tls' that do not have a 'tls_certificate_name' defined.

**Source Code:** [mgc_lb_ensure_tls_listener_has_cert.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/loadbalancer/mgc_lb_ensure_tls_listener_has_cert.rego)
---

## MGC.LB.003: Ensure Load Balancer backends have Health Checks

**Severity:** !!! warning "MEDIUM"

**Category:** `Load Balancer`

**Description:**
Detects backends ('mgc_lbaas_network') that do not have a 'health_check_name' associated.

**Source Code:** [mgc_lb_ensure_backend_health_check.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/loadbalancer/mgc_lb_ensure_backend_health_check.rego)
---

## MGC.LB.004: Ensure external Load Balancers have a Public IP

**Severity:** !!! danger "HIGH"

**Category:** `Load Balancer`

**Description:**
Detects external Load Balancers ('mgc_lbaas_network') that do not have a 'public_ip_id' associated.

**Source Code:** [mgc_lb_ensure_external_lb_has_public_ip.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/loadbalancer/mgc_lb_ensure_external_lb_has_public_ip.rego)
---

