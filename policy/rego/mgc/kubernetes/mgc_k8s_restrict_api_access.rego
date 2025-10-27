package main
import input.resource_changes as resource_changes

__rego_metadata__ := {
    "id": "MGC.K8S.001",
    "title": "Restrict Kubernetes Cluster API access",
    "description": "Detects Kubernetes clusters ('mgc_kubernetes_cluster') that do not define 'allowed_cidrs' or that allow unrestricted access.",
    "severity": "HIGH",
    "category": "Kubernetes"
}

deny contains msg if {
    resource_change := resource_changes[_]
    resource_change.type == "mgc_kubernetes_cluster"
    config := resource_change.change.after
    
    not config.allowed_cidrs

    msg := sprintf("Kubernetes cluster '%s' does not define 'allowed_cidrs', defaulting to open access.", [resource_change.address])
}

deny contains msg if {
    resource_change := resource_changes[_]
    resource_change.type == "mgc_kubernetes_cluster"
    config := resource_change.change.after

    config.allowed_cidrs[_] == "0.0.0.0/0"

    msg := sprintf("Kubernetes cluster '%s' allows unrestricted API access from '0.0.0.0/0'.", [resource_change.address])
}