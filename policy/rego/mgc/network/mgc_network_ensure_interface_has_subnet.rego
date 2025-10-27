package main

__rego_metadata__ := {
    "id": "MGC.NET.016", "title": "Ensure VPC Interfaces are associated with a Subnet",
    "description": "Detects 'mgc_network_vpcs_interfaces' created without an association to 'subnet_ids'.", "severity": "MEDIUM", "category": "Network"
}

deny contains msg if {
    resource := input.configuration.root_module.resources[_]
    resource.type == "mgc_network_vpcs_interfaces"
    config := resource.expressions
    not config.subnet_ids
    msg := sprintf("VPC Interface '%s' is being created without an association to 'subnet_ids'.", [resource.address])
}