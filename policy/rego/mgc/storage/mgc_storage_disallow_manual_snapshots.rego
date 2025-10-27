package main

__rego_metadata__ := {
    "id": "MGC.STORAGE.004", "title": "Disallow manual Block Storage snapshots",
    "description": "Detects the use of manual snapshots ('mgc_block_storage_snapshots'). Use 'mgc_block_storage_schedule' for automation.", "severity": "LOW", "category": "Storage"
}

deny contains msg if {
    resource := input.configuration.root_module.resources[_]
    resource.type == "mgc_block_storage_snapshots"
    msg := sprintf("Resource '%s' is a manual snapshot. Use 'mgc_block_storage_schedule' for automation.", [resource.address])
}