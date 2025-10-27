package main
import input.resource_changes as resource_changes

__rego_metadata__ := {
    "id": "MGC.DB.005",
    "title": "Ensure DBaaS Instances use custom Parameter Groups",
    "description": "Detects DBaaS instances ('mgc_dbaas_instances') that do not specify a 'parameter_group', thus using the system default.",
    "severity": "LOW",
    "category": "Database"
}

deny contains msg if {
    resource_change := resource_changes[_]
    resource_change.type == "mgc_dbaas_instances"
    config := resource_change.change.after
    
    not config.parameter_group

    msg := sprintf("DBaaS instance '%s' does not specify a 'parameter_group', and will use the system default.", [resource_change.address])
}