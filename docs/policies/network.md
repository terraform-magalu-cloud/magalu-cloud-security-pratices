# Network Policies

## MGC.NET.001: Public SSH access is not allowed

**Severity:** !!! critical "CRITICAL"

**Category:** `Network`

**Description:**
Detects security group ingress rules that allow unrestricted access to SSH (port 22).

**Source Code:** [mgc_network_deny_public_ssh.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/network/mgc_network_deny_public_ssh.rego)
---

## MGC.NET.002: Public RDP access is not allowed

**Severity:** !!! critical "CRITICAL"

**Category:** `Network`

**Description:**
Detects security group ingress rules that allow unrestricted access to RDP (port 3389).

**Source Code:** [mgc_network_deny_public_rdp.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/network/mgc_network_deny_public_rdp.rego)
---

## MGC.NET.003: Public SSH access over IPv6 is not allowed

**Severity:** !!! critical "CRITICAL"

**Category:** `Network`

**Description:**
Detects security group ingress rules that allow unrestricted access from any IPv6 address (::/0) to SSH (port 22).

**Source Code:** [mgc_network_deny_public_ssh_ipv6.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/network/mgc_network_deny_public_ssh_ipv6.rego)
---

## MGC.NET.004: Security Group Rule without description

**Severity:** !!! info "LOW"

**Category:** `Network`

**Description:**
Detects Security Group Rules created without a description.

**Source Code:** [mgc_network_ensure_rule_description.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/network/mgc_network_ensure_rule_description.rego)
---

## MGC.NET.005: Security Group without description

**Severity:** !!! info "LOW"

**Category:** `Network`

**Description:**
Detects Security Groups created without a description.

**Source Code:** [mgc_network_ensure_group_description.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/network/mgc_network_ensure_group_description.rego)
---

## MGC.NET.006: Block unrestricted public access to sensitive ports

**Severity:** !!! danger "HIGH"

**Category:** `Network`

**Description:**
Detects rules that expose a list of well-known sensitive ports to the public internet.

**Source Code:** [mgc_network_deny_public_sensitive_ports.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/network/mgc_network_deny_public_sensitive_ports.rego)
---

## MGC.NET.007: Block publicly exposed port ranges

**Severity:** !!! danger "HIGH"

**Category:** `Network`

**Description:**
Detects security rules that expose a range of ports (more than one) to the public internet.

**Source Code:** [mgc_network_deny_public_port_range.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/network/mgc_network_deny_public_port_range.rego)
---

## MGC.NET.008: Block 'Allow All' public security rules

**Severity:** !!! critical "CRITICAL"

**Category:** `Network`

**Description:**
Detects security rules that allow all traffic from all ports from the public internet.

**Source Code:** [mgc_network_deny_all_traffic_public.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/network/mgc_network_deny_all_traffic_public.rego)
---

## MGC.NET.009: Ensure Security Groups disable default rules

**Severity:** !!! warning "MEDIUM"

**Category:** `Network`

**Description:**
Detects 'mgc_network_security_groups' that do not set 'disable_default_rules = true'.

**Source Code:** [mgc_network_enforce_disable_default_rules.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/network/mgc_network_enforce_disable_default_rules.rego)
---

## MGC.NET.010: Block unknown ports exposed publicly

**Severity:** !!! warning "MEDIUM"

**Category:** `Network`

**Description:**
Detects security rules that expose non-standard web ports (other than 80, 443) to the public internet.

**Source Code:** [mgc_network_deny_public_unknown_ports.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/network/mgc_network_deny_public_unknown_ports.rego)
---

## MGC.NET.011: Detect overly broad internal access to database ports

**Severity:** !!! warning "MEDIUM"

**Category:** `Network`

**Description:**
Detects rules that allow access from very wide private CIDRs to database ports.

**Source Code:** [mgc_network_restrict_wide_internal_db_access.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/network/mgc_network_restrict_wide_internal_db_access.rego)
---

## MGC.NET.012: Ensure VPCs have a description

**Severity:** !!! info "LOW"

**Category:** `Network`

**Description:**
Detects 'mgc_network_vpcs' created without a 'description'.

**Source Code:** [mgc_network_ensure_vpc_description.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/network/mgc_network_ensure_vpc_description.rego)
---

## MGC.NET.013: Ensure Subnets have a description

**Severity:** !!! info "LOW"

**Category:** `Network`

**Description:**
Detects 'mgc_network_vpcs_subnets' created without a 'description'.

**Source Code:** [mgc_network_ensure_subnet_description.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/network/mgc_network_ensure_subnet_description.rego)
---

## MGC.NET.014: Restrict Subnets with overly large network masks

**Severity:** !!! warning "MEDIUM"

**Category:** `Network`

**Description:**
Detects 'mgc_network_vpcs_subnets' with a CIDR mask larger than /20.

**Source Code:** [mgc_network_restrict_large_subnet_mask.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/network/mgc_network_restrict_large_subnet_mask.rego)
---

## MGC.NET.015: Ensure Subnets have explicit DNS servers

**Severity:** !!! info "LOW"

**Category:** `Network`

**Description:**
Detects 'mgc_network_vpcs_subnets' that do not define 'dns_nameservers' explicitly.

**Source Code:** [mgc_network_ensure_subnet_dns.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/network/mgc_network_ensure_subnet_dns.rego)
---

## MGC.NET.016: Ensure VPC Interfaces are associated with a Subnet

**Severity:** !!! warning "MEDIUM"

**Category:** `Network`

**Description:**
Detects 'mgc_network_vpcs_interfaces' created without an association to 'subnet_ids'.

**Source Code:** [mgc_network_ensure_interface_has_subnet.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/network/mgc_network_ensure_interface_has_subnet.rego)
---

