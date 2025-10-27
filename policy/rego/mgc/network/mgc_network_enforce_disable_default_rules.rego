package main

__rego_metadata__ := {
    "id": "MGC.NET.009", "title": "Ensure Security Groups disable default rules",
    "description": "Detects 'mgc_network_security_groups' that do not set 'disable_default_rules = true'.", "severity": "MEDIUM", "category": "Network"
}

deny contains msg if {
    resource := input.configuration.root_module.resources[_]
    resource.type == "mgc_network_security_groups"
    config := resource.expressions
    object.get(config, "disable_default_rules", {"constant_value": false}).constant_value != true
    msg := sprintf("Security Group '%s' does not explicitly set 'disable_default_rules = true'.", [resource.address])
}