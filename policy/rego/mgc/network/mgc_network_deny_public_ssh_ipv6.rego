package main

__rego_metadata__ := {
    "id": "MGC.NET.003", "title": "Public SSH access over IPv6 is not allowed",
    "description": "Detects security group ingress rules that allow unrestricted access from any IPv6 address (::/0) to SSH (port 22).",
    "severity": "CRITICAL", "category": "Network"
}

deny contains msg if {
    resource := input.configuration.root_module.resources[_]
    resource.type == "mgc_network_security_groups_rules"
    config := resource.expressions
    config.direction.constant_value == "ingress"
    config.protocol.constant_value == "tcp"
    config.remote_ip_prefix.constant_value == "::/0"
    to_number(config.port_range_min.constant_value) <= 22
    to_number(config.port_range_max.constant_value) >= 22
    msg := sprintf("Resource '%s' exposes SSH (port 22) to the public internet over IPv6.", [resource.address])
}