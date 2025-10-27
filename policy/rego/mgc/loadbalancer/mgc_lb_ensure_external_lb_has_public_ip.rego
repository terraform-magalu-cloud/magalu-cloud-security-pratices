package main

__rego_metadata__ := {
    "id": "MGC.LB.004",
    "title": "Ensure external Load Balancers have a Public IP",
    "description": "Detects external Load Balancers ('mgc_lbaas_network') that do not have a 'public_ip_id' associated.",
    "severity": "HIGH",
    "category": "Load Balancer"
}

deny contains msg if {
    resource := input.configuration.root_module.resources[_]
    resource.type == "mgc_lbaas_network"
    config := resource.expressions
    
    config.visibility.constant_value == "external"
    not config.public_ip_id

    msg := sprintf("External Load Balancer '%s' does not have a 'public_ip_id' associated.", [resource.address])
}