package main
import input.resource_changes as resource_changes

__rego_metadata__ := {
    "id": "MGC.LB.001",
    "title": "Ensure external Load Balancers use TLS (HTTPS)",
    "description": "Detects Load Balancers ('mgc_lbaas_network') with 'visibility = external' that do not have any 'tls' listener configured.",
    "severity": "HIGH",
    "category": "Load Balancer"
}

deny contains msg if {
    resource_change := resource_changes[_]
    resource_change.type == "mgc_lbaas_network"
    config := resource_change.change.after
    
    config.visibility == "external"
    
    listener_protocols := { l.protocol | l := config.listeners[_] }
    not "tls" in listener_protocols

    msg := sprintf("External Load Balancer '%s' does not have any listener configured for 'tls'.", [resource_change.address])
}