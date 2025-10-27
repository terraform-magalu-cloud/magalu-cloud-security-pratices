package main
import input.resource_changes as resource_changes

__rego_metadata__ := {
    "id": "MGC.DB.006",
    "title": "Ensure DBaaS Clusters use custom Parameter Groups",
    "description": "Detects DBaaS clusters ('mgc_dbaas_clusters') that do not specify a 'parameter_group', thus using the system default.",
    "severity": "LOW",
    "category": "Database"
}

deny contains msg if {
    resource_change := resource_changes[_]
    resource_change.type == "mgc_dbaas_clusters"
    config := resource_change.change.after
    
    not config.parameter_group

    msg := sprintf("DBaaS cluster '%s' does not specify a 'parameter_group', and will use the system default.", [resource_change.address])
}