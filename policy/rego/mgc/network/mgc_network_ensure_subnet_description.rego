package main

__rego_metadata__ := {
    "id": "MGC.NET.013", "title": "Ensure Subnets have a description",
    "description": "Detects 'mgc_network_vpcs_subnets' created without a 'description'.", "severity": "LOW", "category": "Network"
}

deny contains msg if {
    resource := input.configuration.root_module.resources[_]
    resource.type == "mgc_network_vpcs_subnets"
    config := resource.expressions
    not config.description
    msg := sprintf("Subnet '%s' does not have a 'description'.", [resource.address])
}