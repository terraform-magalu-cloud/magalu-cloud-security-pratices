package main
import input.resource_changes as resource_changes

__rego_metadata__ := {
    "id": "MGC.K8S.004",
    "title": "Ensure logical Nodepool autoscaling configuration",
    "description": "Detects nodepools ('mgc_kubernetes_nodepool') where 'min_replicas' is greater than or equal to 'max_replicas'.",
    "severity": "MEDIUM",
    "category": "Kubernetes"
}

deny contains msg if {
    resource_change := resource_changes[_]
    resource_change.type == "mgc_kubernetes_nodepool"
    config := resource_change.change.after
    
    config.min_replicas
    config.max_replicas

    to_number(config.min_replicas) >= to_number(config.max_replicas)

    msg := sprintf("Nodepool '%s' has 'min_replicas' (%s) greater than or equal to 'max_replicas' (%s).", [resource_change.address, config.min_replicas, config.max_replicas])
}