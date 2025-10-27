package main

__rego_metadata__ := {
    "id": "MGC.NET.008", "title": "Block 'Allow All' public security rules",
    "description": "Detects security rules that allow all traffic from all ports from the public internet.", "severity": "CRITICAL", "category": "Network"
}

unrestricted_cidrs := {"0.0.0.0/0", "::/0"}

deny contains msg if {
    resource := input.configuration.root_module.resources[_]
    resource.type == "mgc_network_security_groups_rules"
    config := resource.expressions
    config.direction.constant_value == "ingress"
    config.remote_ip_prefix.constant_value in unrestricted_cidrs
    not config.protocol
    not config.port_range_min
    not config.port_range_max
    msg := sprintf("Security Group Rule '%s' allows unrestricted access (All Ports/All Protocols) from %s.", [resource.address, config.remote_ip_prefix.constant_value])
}