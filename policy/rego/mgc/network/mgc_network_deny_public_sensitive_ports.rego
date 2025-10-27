package main

__rego_metadata__ := {
    "id": "MGC.NET.006", "title": "Block unrestricted public access to sensitive ports",
    "description": "Detects rules that expose a list of well-known sensitive ports to the public internet.", "severity": "HIGH", "category": "Network"
}

sensitive_ports := {20, 21, 23, 25, 110, 135, 143, 445, 1433, 1434, 3306, 5432, 6379, 27017}
unrestricted_cidrs := {"0.0.0.0/0", "::/0"}

deny contains msg if {
    resource := input.configuration.root_module.resources[_]
    resource.type == "mgc_network_security_groups_rules"
    config := resource.expressions
    config.direction.constant_value == "ingress"
    config.remote_ip_prefix.constant_value in unrestricted_cidrs
    some port in sensitive_ports
    port >= to_number(config.port_range_min.constant_value)
    port <= to_number(config.port_range_max.constant_value)
    msg := sprintf("Security Group Rule '%s' exposes sensitive port %d publicly to %s.", [resource.address, port, config.remote_ip_prefix.constant_value])
}