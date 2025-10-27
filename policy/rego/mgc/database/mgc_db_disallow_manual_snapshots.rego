package main
import input.resource_changes as resource_changes

__rego_metadata__ := {
    "id": "MGC.DB.003",
    "title": "Disallow manual snapshots of DBaaS Instances",
    "description": "Detects the use of manual snapshots ('mgc_dbaas_instances_snapshots'). Automated backups are preferred.",
    "severity": "MEDIUM",
    "category": "Database"
}

deny contains msg if {
    resource_change := resource_changes[_]
    resource_change.type == "mgc_dbaas_instances_snapshots"
    
    msg := sprintf("Resource '%s' represents a manual snapshot. Prefer automated backup schedules.", [resource_change.address])
}