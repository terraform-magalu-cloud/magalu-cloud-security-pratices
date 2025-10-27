package main

__rego_metadata__ := {
    "id": "MGC.STORAGE.008", "title": "Ensure versioning is enabled on Object Storage Buckets",
    "description": "Detects 'mgc_object_storage_buckets' that do not have 'enable_versioning = true'.", "severity": "MEDIUM", "category": "Storage"
}

deny contains msg if {
    resource := input.configuration.root_module.resources[_]
    resource.type == "mgc_object_storage_buckets"
    config := resource.expressions
    object.get(config, "enable_versioning", {"constant_value": false}).constant_value != true
    msg := sprintf("Object Storage Bucket '%s' does not have versioning enabled ('enable_versioning = true').", [resource.address])
}