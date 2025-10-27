package main

__rego_metadata__ := {
    "id": "MGC.NET.002", "title": "Public RDP access is not allowed",
    "description": "Detects security group ingress rules that allow unrestricted access to RDP (port 3389).",
    "severity": "CRITICAL", "category": "Network"
}

deny contains msg if {
    resource := input.configuration.root_module.resources[_]
    resource.type == "mgc_network_security_groups_rules"
    config := resource.expressions
    config.direction.constant_value == "ingress"
    config.protocol.constant_value == "tcp"
    unrestricted_cidrs := {"0.0.0.0/0", "::/0"}
    config.remote_ip_prefix.constant_value in unrestricted_cidrs
    to_number(config.port_range_min.constant_value) <= 3389
    to_number(config.port_range_max.constant_value) >= 3389
    msg := sprintf("Resource '%s' exposes RDP (port 3389) to the public internet.", [resource.address])
}