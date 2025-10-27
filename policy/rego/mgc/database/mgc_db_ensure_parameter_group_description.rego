package main

__rego_metadata__ := {
    "id": "MGC.DB.004", "title": "Ensure DBaaS Parameter Groups have a description",
    "description": "Detects DBaaS parameter groups ('mgc_dbaas_parameter_groups') created without a description.",
    "severity": "LOW", "category": "Database"
}

deny contains msg if {
    resource := input.configuration.root_module.resources[_]
    resource.type == "mgc_dbaas_parameter_groups"
    config := resource.expressions
    object.get(config, "description", {"constant_value": ""}).constant_value == ""
    msg := sprintf("DBaaS parameter group '%s' does not have a description.", [resource.address])
}