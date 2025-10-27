package main

__rego_metadata__ := {
    "id": "MGC.STORAGE.003", "title": "Ensure snapshot schedules have a description",
    "description": "Detects snapshot schedules ('mgc_block_storage_schedule') created without a description.", "severity": "LOW", "category": "Storage"
}

deny contains msg if {
    resource := input.configuration.root_module.resources[_]
    resource.type == "mgc_block_storage_schedule"
    config := resource.expressions
    not config.description
    msg := sprintf("Snapshot schedule '%s' does not have a description.", [resource.address])
}