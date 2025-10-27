# Database Policies

## MGC.DB.001: Ensure minimum backup retention for DBaaS Instances

**Severity:** !!! danger "HIGH"

**Category:** `Database`

**Description:**
Detects DBaaS instances ('mgc_dbaas_instances') with a backup retention period of less than 7 days.

**Source Code:** [mgc_db_instance_ensure_minimum_backup_retention.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/database/mgc_db_instance_ensure_minimum_backup_retention.rego)
---

## MGC.DB.002: Ensure minimum backup retention for DBaaS Clusters

**Severity:** !!! danger "HIGH"

**Category:** `Database`

**Description:**
Detects DBaaS clusters ('mgc_dbaas_clusters') with a backup retention period of less than 7 days.

**Source Code:** [mgc_db_cluster_ensure_minimum_backup_retention.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/database/mgc_db_cluster_ensure_minimum_backup_retention.rego)
---

## MGC.DB.003: Disallow manual snapshots of DBaaS Instances

**Severity:** !!! warning "MEDIUM"

**Category:** `Database`

**Description:**
Detects the use of manual snapshots ('mgc_dbaas_instances_snapshots'). Automated backups are preferred.

**Source Code:** [mgc_db_disallow_manual_snapshots.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/database/mgc_db_disallow_manual_snapshots.rego)
---

## MGC.DB.004: Ensure DBaaS Parameter Groups have a description

**Severity:** !!! info "LOW"

**Category:** `Database`

**Description:**
Detects DBaaS parameter groups ('mgc_dbaas_parameter_groups') created without a description.

**Source Code:** [mgc_db_ensure_parameter_group_description.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/database/mgc_db_ensure_parameter_group_description.rego)
---

## MGC.DB.005: Ensure DBaaS Instances use custom Parameter Groups

**Severity:** !!! info "LOW"

**Category:** `Database`

**Description:**
Detects DBaaS instances ('mgc_dbaas_instances') that do not specify a 'parameter_group', thus using the system default.

**Source Code:** [mgc_db_instance_ensure_custom_parameter_group.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/database/mgc_db_instance_ensure_custom_parameter_group.rego)
---

## MGC.DB.006: Ensure DBaaS Clusters use custom Parameter Groups

**Severity:** !!! info "LOW"

**Category:** `Database`

**Description:**
Detects DBaaS clusters ('mgc_dbaas_clusters') that do not specify a 'parameter_group', thus using the system default.

**Source Code:** [mgc_db_cluster_ensure_custom_parameter_group.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/database/mgc_db_cluster_ensure_custom_parameter_group.rego)
---

