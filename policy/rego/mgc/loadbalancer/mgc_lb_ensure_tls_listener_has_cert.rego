package main
import input.resource_changes as resource_changes

__rego_metadata__ := {
    "id": "MGC.LB.002",
    "title": "Ensure TLS listeners have an associated certificate",
    "description": "Detects listeners ('mgc_lbaas_network.listeners') with 'protocol = tls' that do not have a 'tls_certificate_name' defined.",
    "severity": "MEDIUM",
    "category": "Load Balancer"
}

deny contains msg if {
    resource_change := resource_changes[_]
    resource_change.type == "mgc_lbaas_network"
    config := resource_change.change.after
    
    listener := config.listeners[_]
    
    listener.protocol == "tls"
    not listener.tls_certificate_name

    msg := sprintf("TLS listener '%s' in Load Balancer '%s' does not have an associated 'tls_certificate_name'.", [listener.name, resource_change.address])
}