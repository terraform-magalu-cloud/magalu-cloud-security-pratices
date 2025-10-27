package main

__rego_metadata__ := {
    "id": "MGC.VM.001",
    "title": "Disallow public IP allocation on VM instances",
    "description": "Detects 'mgc_virtual_machine_instances' that are configured to allocate a public IP on boot.",
    "severity": "HIGH",
    "category": "Virtual Machine"
}

deny contains msg if {
    # Itera sobre os recursos na estrutura que validamos
    resource := input.configuration.root_module.resources[_]
    resource.type == "mgc_virtual_machine_instances"
    
    config := resource.expressions
    
    # CORREÇÃO DEFINITIVA:
    # 1. Usa 'object.get' para acessar a chave 'allocate_public_ipv4' de forma segura.
    # 2. Se a chave não existir (PASS case), ele retorna o valor padrão: {"constant_value": false}.
    # 3. Se a chave existir (FAIL case), ele retorna o valor real: {"constant_value": true}.
    public_ip_config := object.get(config, "allocate_public_ipv4", {"constant_value": false})
    
    # 4. Compara o 'constant_value' do resultado.
    public_ip_config.constant_value == true

    msg := sprintf("VM instance '%s' is configured to allocate a public IP.", [resource.address])
}