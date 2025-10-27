package main

__rego_metadata__ := {
    "id": "MGC.STORAGE.002", "title": "Ensure minimum snapshot retention",
    "description": "Detects snapshot schedules ('mgc_block_storage_schedule') with a retention period of less than 7 days.", "severity": "MEDIUM", "category": "Storage"
}

minimum_retention_days := 7

deny contains msg if {
    resource := input.configuration.root_module.resources[_]
    resource.type == "mgc_block_storage_schedule"
    config := resource.expressions
    to_number(config.policy_retention_in_days.constant_value) < minimum_retention_days
    msg := sprintf("Snapshot schedule '%s' has a retention of %s days, which is less than the minimum of %d days.", [resource.address, config.policy_retention_in_days.constant_value, minimum_retention_days])
}