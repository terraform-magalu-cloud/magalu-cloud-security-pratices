package main

__rego_metadata__ := {
    "id": "MGC.NET.014", "title": "Restrict Subnets with overly large network masks",
    "description": "Detects 'mgc_network_vpcs_subnets' with a CIDR mask larger than /20.", "severity": "MEDIUM", "category": "Network"
}

min_mask_prefix := 20

deny contains msg if {
    resource := input.configuration.root_module.resources[_]
    resource.type == "mgc_network_vpcs_subnets"
    config := resource.expressions
    split_cidr := split(config.cidr_block.constant_value, "/")
    count(split_cidr) == 2
    mask_size := to_number(split_cidr[1])
    mask_size < min_mask_prefix
    msg := sprintf("Subnet '%s' has a CIDR (%s) with a mask /%d, which is larger than the recommended /%d.", [resource.address, config.cidr_block.constant_value, mask_size, min_mask_prefix])
}