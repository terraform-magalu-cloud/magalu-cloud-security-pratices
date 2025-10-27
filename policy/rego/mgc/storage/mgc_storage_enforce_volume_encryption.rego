package main

__rego_metadata__ := {
    "id": "MGC.STORAGE.001", "title": "Ensure Storage volumes are encrypted",
    "description": "Detects volumes ('mgc_block_storage_volumes') that are not configured for encryption at rest.", "severity": "HIGH", "category": "Storage"
}

deny contains msg if {
    resource := input.configuration.root_module.resources[_]
    resource.type == "mgc_block_storage_volumes"
    config := resource.expressions
    object.get(config, "encrypted", {"constant_value": false}).constant_value != true
    msg := sprintf("Block Storage volume '%s' is not configured for encryption ('encrypted = true').", [resource.address])
}