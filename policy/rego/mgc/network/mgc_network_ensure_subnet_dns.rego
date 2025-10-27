package main

__rego_metadata__ := {
    "id": "MGC.NET.015", "title": "Ensure Subnets have explicit DNS servers",
    "description": "Detects 'mgc_network_vpcs_subnets' that do not define 'dns_nameservers' explicitly.", "severity": "LOW", "category": "Network"
}

deny contains msg if {
    resource := input.configuration.root_module.resources[_]
    resource.type == "mgc_network_vpcs_subnets"
    config := resource.expressions
    not config.dns_nameservers
    msg := sprintf("Subnet '%s' does not explicitly define 'dns_nameservers'.", [resource.address])
}