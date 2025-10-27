package main

__rego_metadata__ := {
    "id": "MGC.STORAGE.005", "title": "Discourage creating volumes from snapshots via Terraform",
    "description": "Detects volumes ('mgc_block_storage_volumes') created from a snapshot, which can indicate a manual recovery process coded into infrastructure.", "severity": "LOW", "category": "Storage"
}

deny contains msg if {
    resource := input.configuration.root_module.resources[_]
    resource.type == "mgc_block_storage_volumes"
    config := resource.expressions
    config.snapshot_id
    msg := sprintf("Volume '%s' is created from a snapshot. Prefer provisioning from a golden image or use database restore mechanisms.", [resource.address])
}