package main

__rego_metadata__ := {
    "id": "MGC.NET.012", "title": "Ensure VPCs have a description",
    "description": "Detects 'mgc_network_vpcs' created without a 'description'.", "severity": "LOW", "category": "Network"
}

deny contains msg if {
    resource := input.configuration.root_module.resources[_]
    resource.type == "mgc_network_vpcs"
    config := resource.expressions
    not config.description
    msg := sprintf("VPC '%s' does not have a 'description'.", [resource.address])
}