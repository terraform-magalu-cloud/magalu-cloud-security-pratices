package main

__rego_metadata__ := {
    "id": "MGC.LB.003", "title": "Ensure Load Balancer backends have Health Checks",
    "description": "Detects backends ('mgc_lbaas_network') that do not have a 'health_check_name' associated.",
    "severity": "MEDIUM", "category": "Load Balancer"
}

deny contains msg if {
    resource := input.configuration.root_module.resources[_]
    resource.type == "mgc_lbaas_network"
    
    # Acessa a lista de backends. Esta parte estava correta.
    backend_list := resource.expressions.backends.constant_value
    
    # Itera sobre cada objeto 'backend' na lista.
    backend := backend_list[_]
    
    # A violação ocorre se a chave 'health_check_name' não existir no objeto 'backend'.
    not backend.health_check_name
    
    # CORREÇÃO: Acessa o atributo 'name' diretamente, pois ele não está aninhado.
    msg := sprintf("Backend '%s' in Load Balancer '%s' does not have an associated 'health_check_name'.", [backend.name, resource.address])
}