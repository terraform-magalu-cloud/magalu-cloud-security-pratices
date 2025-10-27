package main

__rego_metadata__ := {
    "id": "MGC.K8S.003", "title": "Ensure anti-affinity for Kubernetes control plane",
    "description": "Detects clusters ('mgc_kubernetes_cluster') that explicitly disable anti-affinity ('enabled_server_group = false').",
    "severity": "MEDIUM", "category": "Kubernetes"
}

deny contains msg if {
    resource := input.configuration.root_module.resources[_]
    resource.type == "mgc_kubernetes_cluster"
    config := resource.expressions
    object.get(config, "enabled_server_group", {"constant_value": true}).constant_value == false
    msg := sprintf("Kubernetes cluster '%s' disables control plane anti-affinity ('enabled_server_group = false').", [resource.address])
}