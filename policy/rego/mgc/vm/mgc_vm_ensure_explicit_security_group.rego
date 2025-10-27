package main

__rego_metadata__ := {
    "id": "MGC.VM.002", "title": "Ensure VM instances explicitly define Security Groups",
    "description": "Detects 'mgc_virtual_machine_instances' that do not define 'creation_security_groups', resulting in using the VPC default.", "severity": "MEDIUM", "category": "Virtual Machine"
}

deny contains msg if {
    resource := input.configuration.root_module.resources[_]
    resource.type == "mgc_virtual_machine_instances"
    config := resource.expressions
    not config.creation_security_groups
    msg := sprintf("VM instance '%s' does not explicitly define 'creation_security_groups' and will use the VPC's default security group.", [resource.address])
}