package main
import input.resource_changes as resource_changes

__rego_metadata__ := {
    "id": "MGC.K8S.005",
    "title": "Ensure Nodepools use multiple Availability Zones (AZ)",
    "description": "Detects nodepools ('mgc_kubernetes_nodepool') that specify 'availability_zones' but list fewer than two zones.",
    "severity": "MEDIUM",
    "category": "Kubernetes"
}

deny contains msg if {
    resource_change := resource_changes[_]
    resource_change.type == "mgc_kubernetes_nodepool"
    config := resource_change.change.after
    
    config.availability_zones
    count(config.availability_zones) < 2

    msg := sprintf("Nodepool '%s' is configured for high availability but is in fewer than 2 Availability Zones.", [resource_change.address])
}