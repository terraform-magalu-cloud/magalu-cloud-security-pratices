#!/bin/bash

set -o pipefail

# --- Configuração ---
POLICY_ROOT_PATH="../policy/rego/mgc"
TEST_CASES_DIR="./cases"
PASS_COUNT=0
FAIL_COUNT=0
TOTAL_SCENARIOS=0

# --- MAPA DE POLÍTICAS (Estrutura Plana) ---
# Mapeia o ID da Política para o nome do arquivo .rego
declare -A POLICY_MAP
POLICY_MAP=(
    ["MGC.DB.001"]="database/mgc_db_instance_ensure_minimum_backup_retention.rego"
    ["MGC.DB.002"]="database/mgc_db_cluster_ensure_minimum_backup_retention.rego"
    ["MGC.DB.003"]="database/mgc_db_disallow_manual_snapshots.rego"
    ["MGC.DB.004"]="database/mgc_db_ensure_parameter_group_description.rego"
    ["MGC.DB.005"]="database/mgc_db_instance_ensure_custom_parameter_group.rego"
    ["MGC.DB.006"]="database/mgc_db_cluster_ensure_custom_parameter_group.rego"
    
    ["MGC.K8S.001"]="kubernetes/mgc_k8s_restrict_api_access.rego"
    ["MGC.K8S.002"]="kubernetes/mgc_k8s_ensure_cluster_description.rego"
    ["MGC.K8S.003"]="kubernetes/mgc_k8s_enforce_anti_affinity.rego"
    ["MGC.K8S.004"]="kubernetes/mgc_k8s_ensure_nodepool_autoscaling_config.rego"
    ["MGC.K8S.005"]="kubernetes/mgc_k8s_ensure_nodepool_multi_az.rego"

    ["MGC.LB.001"]="loadbalancer/mgc_lb_ensure_external_uses_tls.rego"
    ["MGC.LB.002"]="loadbalancer/mgc_lb_ensure_tls_listener_has_cert.rego"
    ["MGC.LB.003"]="loadbalancer/mgc_lb_ensure_backend_health_check.rego"
    ["MGC.LB.004"]="loadbalancer/mgc_lb_ensure_external_lb_has_public_ip.rego"

    ["MGC.NET.001"]="network/mgc_network_deny_public_ssh.rego"
    ["MGC.NET.002"]="network/mgc_network_deny_public_rdp.rego"
    ["MGC.NET.003"]="network/mgc_network_deny_public_ssh_ipv6.rego"
    ["MGC.NET.004"]="network/mgc_network_ensure_rule_description.rego"
    ["MGC.NET.005"]="network/mgc_network_ensure_group_description.rego"
    ["MGC.NET.006"]="network/mgc_network_deny_public_sensitive_ports.rego"
    ["MGC.NET.007"]="network/mgc_network_deny_public_port_range.rego"
    ["MGC.NET.008"]="network/mgc_network_deny_all_traffic_public.rego"
    ["MGC.NET.009"]="network/mgc_network_enforce_disable_default_rules.rego"
    ["MGC.NET.010"]="network/mgc_network_deny_public_unknown_ports.rego"
    ["MGC.NET.011"]="network/mgc_network_restrict_wide_internal_db_access.rego"
    ["MGC.NET.012"]="network/mgc_network_ensure_vpc_description.rego"
    ["MGC.NET.013"]="network/mgc_network_ensure_subnet_description.rego"
    ["MGC.NET.014"]="network/mgc_network_restrict_large_subnet_mask.rego"
    ["MGC.NET.015"]="network/mgc_network_ensure_subnet_dns.rego"
    ["MGC.NET.016"]="network/mgc_network_ensure_interface_has_subnet.rego"

    ["MGC.STORAGE.001"]="storage/mgc_storage_enforce_volume_encryption.rego"
    ["MGC.STORAGE.002"]="storage/mgc_storage_ensure_minimum_retention.rego"
    ["MGC.STORAGE.003"]="storage/mgc_storage_ensure_schedule_description.rego"
    ["MGC.STORAGE.004"]="storage/mgc_storage_disallow_manual_snapshots.rego"
    ["MGC.STORAGE.005"]="storage/mgc_storage_disallow_volume_from_snapshot.rego"
    ["MGC.STORAGE.006"]="storage/mgc_storage_deny_public_read.rego"
    ["MGC.STORAGE.007"]="storage/mgc_storage_deny_public_write.rego"
    ["MGC.STORAGE.008"]="storage/mgc_storage_enforce_bucket_versioning.rego"

    ["MGC.VM.001"]="vm/mgc_vm_disallow_public_ip.rego"
    ["MGC.VM.002"]="vm/mgc_vm_ensure_explicit_security_group.rego"
    ["MGC.VM.003"]="vm/mgc_vm_ensure_ssh_key.rego"
    ["MGC.VM.004"]="vm/mgc_vm_disallow_manual_snapshots.rego"
)


# Cores
GREEN='\033[0;32m'; RED='\033[0;31m'; YELLOW='\033[1;33m'; NC='\033[0m'

echo "========================================="
echo "  Running Conftest Policy Tests"
echo "========================================="

if [ ! -d "${TEST_CASES_DIR}" ]; then
    echo -e "${RED}Error: Test cases directory not found at '${TEST_CASES_DIR}'.${NC}"; exit 1;
fi

for policy_dir in ${TEST_CASES_DIR}/*; do
    if [ -d "${policy_dir}" ]; then
        POLICY_ID=$(basename "${policy_dir}")

        
        echo -e "\n${YELLOW}► Testing Policy: ${POLICY_ID}${NC}"

        if [ "$POLICY_ID" == "MGC.VM.001" ]; then
            echo "  (Using HCL parser for this test)"
            
            # Teste FAIL (espera falha)
            ((TOTAL_SCENARIOS++))
            echo "  ├─ Running FAIL case (expected to fail)..."
            if ! conftest test --policy "${POLICY_FILE}" "${policy_dir}/fail/" > /dev/null 2>&1; then
                echo -e "  │  └─ ${GREEN}[PASS]${NC} Policy correctly failed as expected."
                ((PASS_COUNT++))
            else
                echo -e "  │  └─ ${RED}[FAIL]${NC} Policy did NOT fail as expected."
                ((FAIL_COUNT++))
            fi

            # Teste PASS (espera sucesso)
            ((TOTAL_SCENARIOS++))
            echo "  └─ Running PASS case (expected to pass)..."
            if conftest test --policy "${POLICY_FILE}" "${policy_dir}/pass/" > /dev/null 2>&1; then
                echo -e "     └─ ${GREEN}[PASS]${NC} Policy correctly passed as expected."
                ((PASS_COUNT++))
            else
                echo -e "     └─ ${RED}[FAIL]${NC} Policy failed unexpectedly (false positive)."
                ((FAIL_COUNT++))
            fi

            continue # Pula para a próxima política no loop
        fi

        policy_file_name=${POLICY_MAP[${POLICY_ID}]}
        
        if [ -z "${policy_file_name}" ]; then
            echo -e "  └─ ${RED}[ERROR]${NC} No policy file mapped for ID ${POLICY_ID} in run_tests.sh. Skipping."
            ((FAIL_COUNT++)); continue;
        fi
        
        POLICY_FILE="${POLICY_ROOT_PATH}/${policy_file_name}"

        if [ ! -f "${POLICY_FILE}" ]; then
            echo -e "  └─ ${RED}[ERROR]${NC} Policy file not found at ${POLICY_FILE}. Skipping."
            ((FAIL_COUNT++)); continue;
        fi
        
        echo "  (Using policy file: ${POLICY_FILE})"

        # --- Teste do Cenário de FALHA (FAIL) ---
        FAIL_DIR="${policy_dir}/fail"
        if [ -d "${FAIL_DIR}" ]; then
            ((TOTAL_SCENARIOS++))
            echo "  ├─ Running FAIL case (expected to fail)..."
            ( cd "${FAIL_DIR}" && terraform init -upgrade > /dev/null 2>&1 && terraform plan -out=tfplan.binary > /dev/null 2>&1 && terraform show -json tfplan.binary > tfplan.json ) &> /dev/null
            if ! conftest test "${FAIL_DIR}/tfplan.json" --policy "${POLICY_FILE}" > /dev/null 2>&1; then
                echo -e "  │  └─ ${GREEN}[PASS]${NC} Policy correctly failed as expected."
                ((PASS_COUNT++))
            else
                echo -e "  │  └─ ${RED}[FAIL]${NC} Policy did NOT fail as expected."
                ((FAIL_COUNT++))
            fi
        fi

        # --- Teste do Cenário de SUCESSO (PASS) ---
        PASS_DIR="${policy_dir}/pass"
        if [ -d "${PASS_DIR}" ]; then
            ((TOTAL_SCENARIOS++))
            echo "  └─ Running PASS case (expected to pass)..."
            ( cd "${PASS_DIR}" && terraform init -upgrade > /dev/null 2>&1 && terraform plan -out=tfplan.binary > /dev/null 2>&1 && terraform show -json tfplan.binary > tfplan.json ) &> /dev/null
            if conftest test "${PASS_DIR}/tfplan.json" --policy "${POLICY_FILE}" > /dev/null 2>&1; then
                echo -e "     └─ ${GREEN}[PASS]${NC} Policy correctly passed as expected."
                ((PASS_COUNT++))
            else
                conftest_output=$(conftest test "${PASS_DIR}/tfplan.json" --policy "${POLICY_FILE}" 2>&1)
                echo -e "     └─ ${RED}[FAIL]${NC} Policy failed unexpectedly (false positive)."
                echo -e "        Error: ${conftest_output}"
                ((FAIL_COUNT++))
            fi
        fi
    fi
done

echo -e "\n========================================="
echo "            Test Summary"
echo "========================================="
echo -e "${GREEN}Successful Scenarios: ${PASS_COUNT} / ${TOTAL_SCENARIOS}${NC}"
if [ ${FAIL_COUNT} -ne 0 ]; then
    echo -e "${RED}Failed Scenarios    : ${FAIL_COUNT}${NC}"
    echo "========================================="
    echo -e "\n${RED}One or more policy tests failed.${NC}"
    exit 1
else
    echo "========================================="
    echo -e "\n${GREEN}All policy tests passed successfully!${NC}"
    exit 0
fi