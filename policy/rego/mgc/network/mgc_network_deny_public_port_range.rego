package main

__rego_metadata__ := {
    "id": "MGC.NET.007", "title": "Block publicly exposed port ranges",
    "description": "Detects security rules that expose a range of ports (more than one) to the public internet.", "severity": "HIGH", "category": "Network"
}

unrestricted_cidrs := {"0.0.0.0/0", "::/0"}

deny contains msg if {
    resource := input.configuration.root_module.resources[_]
    resource.type == "mgc_network_security_groups_rules"
    config := resource.expressions
    config.direction.constant_value == "ingress"
    config.remote_ip_prefix.constant_value in unrestricted_cidrs
    to_number(config.port_range_max.constant_value) > to_number(config.port_range_min.constant_value)
    msg := sprintf("Security Group Rule '%s' exposes a port range (%s-%s) publicly to %s.", [resource.address, config.port_range_min.constant_value, config.port_range_max.constant_value, config.remote_ip_prefix.constant_value])
}