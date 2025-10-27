package main
import input.resource_changes as resource_changes

__rego_metadata__ := {
    "id": "MGC.DB.002",
    "title": "Ensure minimum backup retention for DBaaS Clusters",
    "description": "Detects DBaaS clusters ('mgc_dbaas_clusters') with a backup retention period of less than 7 days.",
    "severity": "HIGH",
    "category": "Database"
}

minimum_retention_days := 7

deny contains msg if {
    resource_change := resource_changes[_]
    resource_change.type == "mgc_dbaas_clusters"
    config := resource_change.change.after
    
    to_number(config.backup_retention_days) < minimum_retention_days

    msg := sprintf("DBaaS cluster '%s' has a retention period of %s days, which is less than the minimum of %d days.", [resource_change.address, config.backup_retention_days, minimum_retention_days])
}