package main

__rego_metadata__ := {
    "id": "MGC.NET.010", "title": "Block unknown ports exposed publicly",
    "description": "Detects security rules that expose non-standard web ports (other than 80, 443) to the public internet.", "severity": "MEDIUM", "category": "Network"
}

allowed_public_ports := {80, 443}
unrestricted_cidrs := {"0.0.0.0/0", "::/0"}

deny contains msg if {
    resource := input.configuration.root_module.resources[_]
    resource.type == "mgc_network_security_groups_rules"
    config := resource.expressions
    
    config.direction.constant_value == "ingress"
    config.remote_ip_prefix.constant_value in unrestricted_cidrs
    
    port_min := to_number(config.port_range_min.constant_value)
    port_max := to_number(config.port_range_max.constant_value)
    
    # A lógica da regra está correta, apenas confirmando o acesso ao 'config'
    port_min == port_max
    not allowed_public_ports[port_min]
    
    msg := sprintf("Security Group Rule '%s' exposes non-standard port %v publicly to %s.", [resource.address, port_min, config.remote_ip_prefix.constant_value])
}