package main

__rego_metadata__ := {
    "id": "MGC.NET.011", "title": "Detect overly broad internal access to database ports",
    "description": "Detects rules that allow access from very wide private CIDRs to database ports.", "severity": "MEDIUM", "category": "Network"
}

sensitive_db_ports := {3306, 5432, 1433, 27017, 6379}
wide_private_cidrs := {"10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"}

deny contains msg if {
    resource := input.configuration.root_module.resources[_]
    resource.type == "mgc_network_security_groups_rules"
    config := resource.expressions
    config.direction.constant_value == "ingress"
    config.remote_ip_prefix.constant_value in wide_private_cidrs
    some port in sensitive_db_ports
    port >= to_number(config.port_range_min.constant_value)
    port <= to_number(config.port_range_max.constant_value)
    msg := sprintf("Security Group Rule '%s' allows access to DB port %d from an overly broad internal CIDR (%s).", [resource.address, port, config.remote_ip_prefix.constant_value])
}