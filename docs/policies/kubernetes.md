# Kubernetes Policies

## MGC.K8S.001: Restrict Kubernetes Cluster API access

**Severity:** !!! danger "HIGH"

**Category:** `Kubernetes`

**Description:**
Detects Kubernetes clusters ('mgc_kubernetes_cluster') that do not define 'allowed_cidrs' or that allow unrestricted access.

**Source Code:** [mgc_k8s_restrict_api_access.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/kubernetes/mgc_k8s_restrict_api_access.rego)
---

## MGC.K8S.002: Ensure Kubernetes Clusters have a description

**Severity:** !!! info "LOW"

**Category:** `Kubernetes`

**Description:**
Detects Kubernetes clusters ('mgc_kubernetes_cluster') created without a description.

**Source Code:** [mgc_k8s_ensure_cluster_description.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/kubernetes/mgc_k8s_ensure_cluster_description.rego)
---

## MGC.K8S.003: Ensure anti-affinity for Kubernetes control plane

**Severity:** !!! warning "MEDIUM"

**Category:** `Kubernetes`

**Description:**
Detects clusters ('mgc_kubernetes_cluster') that explicitly disable anti-affinity ('enabled_server_group = false').

**Source Code:** [mgc_k8s_enforce_anti_affinity.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/kubernetes/mgc_k8s_enforce_anti_affinity.rego)
---

## MGC.K8S.004: Ensure logical Nodepool autoscaling configuration

**Severity:** !!! warning "MEDIUM"

**Category:** `Kubernetes`

**Description:**
Detects nodepools ('mgc_kubernetes_nodepool') where 'min_replicas' is greater than or equal to 'max_replicas'.

**Source Code:** [mgc_k8s_ensure_nodepool_autoscaling_config.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/kubernetes/mgc_k8s_ensure_nodepool_autoscaling_config.rego)
---

## MGC.K8S.005: Ensure Nodepools use multiple Availability Zones (AZ)

**Severity:** !!! warning "MEDIUM"

**Category:** `Kubernetes`

**Description:**
Detects nodepools ('mgc_kubernetes_nodepool') that specify 'availability_zones' but list fewer than two zones.

**Source Code:** [mgc_k8s_ensure_nodepool_multi_az.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/kubernetes/mgc_k8s_ensure_nodepool_multi_az.rego)
---

