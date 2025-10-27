package main

__rego_metadata__ := {
    "id": "MGC.STORAGE.006", "title": "Disallow public read access on Object Storage Buckets",
    "description": "Detects 'mgc_object_storage_buckets' that allow public read access.", "severity": "CRITICAL", "category": "Storage"
}

deny contains msg if {
    resource := input.configuration.root_module.resources[_]
    resource.type == "mgc_object_storage_buckets"
    config := resource.expressions
    object.get(config, "public_read", {"constant_value": false}).constant_value == true
    msg := sprintf("Object Storage Bucket '%s' allows public read access ('public_read = true').", [resource.address])
}

deny contains msg if {
    resource := input.configuration.root_module.resources[_]
    resource.type == "mgc_object_storage_buckets"
    config := resource.expressions
    object.get(config, "public_read_write", {"constant_value": false}).constant_value == true
    msg := sprintf("Object Storage Bucket '%s' allows public read access via 'public_read_write = true'.", [resource.address])
}