package main

__rego_metadata__ := {
    "id": "MGC.STORAGE.007", "title": "Disallow public write access on Object Storage Buckets",
    "description": "Detects 'mgc_object_storage_buckets' that allow public write access.", "severity": "CRITICAL", "category": "Storage"
}

deny contains msg if {
    resource := input.configuration.root_module.resources[_]
    resource.type == "mgc_object_storage_buckets"
    config := resource.expressions
    object.get(config, "public_read_write", {"constant_value": false}).constant_value == true
    msg := sprintf("Object Storage Bucket '%s' allows public write access ('public_read_write = true').", [resource.address])
}