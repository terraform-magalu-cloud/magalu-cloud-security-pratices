package main

__rego_metadata__ := {
    "id": "MGC.K8S.002", "title": "Ensure Kubernetes Clusters have a description",
    "description": "Detects Kubernetes clusters ('mgc_kubernetes_cluster') created without a description.",
    "severity": "LOW", "category": "Kubernetes"
}

deny contains msg if {
    resource := input.configuration.root_module.resources[_]
    resource.type == "mgc_kubernetes_cluster"
    config := resource.expressions
    object.get(config, "description", {"constant_value": ""}).constant_value == ""
    msg := sprintf("Kubernetes cluster '%s' does not have a description.", [resource.address])
}