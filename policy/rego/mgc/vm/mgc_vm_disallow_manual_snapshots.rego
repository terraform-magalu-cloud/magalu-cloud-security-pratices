package main
import input.resource_changes as resource_changes

__rego_metadata__ := {
    "id": "MGC.VM.004",
    "title": "Disallow manual snapshots of VM instances",
    "description": "Detects the use of manual VM snapshots ('mgc_virtual_machine_snapshots'). Prefer automated block storage backup schedules.",
    "severity": "LOW",
    "category": "Virtual Machine"
}

deny contains msg if {
    resource_change := resource_changes[_]
    resource_change.type == "mgc_virtual_machine_snapshots"
    msg := sprintf("Resource '%s' is a manual VM snapshot. Prefer automated backup schedules on the attached block storage volumes.", [resource_change.address])
}