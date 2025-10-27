package main

__rego_metadata__ := {
    "id": "MGC.NET.005", "title": "Security Group without description",
    "description": "Detects Security Groups created without a description.", "severity": "LOW", "category": "Network"
}

deny contains msg if {
    resource := input.configuration.root_module.resources[_]
    resource.type == "mgc_network_security_groups"
    config := resource.expressions
    not config.description
    msg := sprintf("Security Group '%s' does not have a description.", [resource.address])
}