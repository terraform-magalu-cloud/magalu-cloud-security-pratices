package main

__rego_metadata__ := {
    "id": "MGC.VM.003", "title": "Ensure non-Windows VM instances have an associated SSH Key",
    "description": "Detects non-Windows 'mgc_virtual_machine_instances' that do not define a 'ssh_key_name'.", "severity": "MEDIUM", "category": "Virtual Machine"
}

deny contains msg if {
    resource := input.configuration.root_module.resources[_]
    resource.type == "mgc_virtual_machine_instances"
    config := resource.expressions
    not contains(lower(config.image.constant_value), "windows")
    not config.ssh_key_name
    msg := sprintf("VM instance '%s' is being created without an associated 'ssh_key_name'.", [resource.address])
}