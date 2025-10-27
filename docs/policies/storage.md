# Storage Policies

## MGC.STORAGE.001: Ensure Storage volumes are encrypted

**Severity:** !!! danger "HIGH"

**Category:** `Storage`

**Description:**
Detects volumes ('mgc_block_storage_volumes') that are not configured for encryption at rest.

**Source Code:** [mgc_storage_enforce_volume_encryption.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/storage/mgc_storage_enforce_volume_encryption.rego)
---

## MGC.STORAGE.002: Ensure minimum snapshot retention

**Severity:** !!! warning "MEDIUM"

**Category:** `Storage`

**Description:**
Detects snapshot schedules ('mgc_block_storage_schedule') with a retention period of less than 7 days.

**Source Code:** [mgc_storage_ensure_minimum_retention.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/storage/mgc_storage_ensure_minimum_retention.rego)
---

## MGC.STORAGE.003: Ensure snapshot schedules have a description

**Severity:** !!! info "LOW"

**Category:** `Storage`

**Description:**
Detects snapshot schedules ('mgc_block_storage_schedule') created without a description.

**Source Code:** [mgc_storage_ensure_schedule_description.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/storage/mgc_storage_ensure_schedule_description.rego)
---

## MGC.STORAGE.004: Disallow manual Block Storage snapshots

**Severity:** !!! info "LOW"

**Category:** `Storage`

**Description:**
Detects the use of manual snapshots ('mgc_block_storage_snapshots'). Use 'mgc_block_storage_schedule' for automation.

**Source Code:** [mgc_storage_disallow_manual_snapshots.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/storage/mgc_storage_disallow_manual_snapshots.rego)
---

## MGC.STORAGE.005: Discourage creating volumes from snapshots via Terraform

**Severity:** !!! info "LOW"

**Category:** `Storage`

**Description:**
Detects volumes ('mgc_block_storage_volumes') created from a snapshot, which can indicate a manual recovery process coded into infrastructure.

**Source Code:** [mgc_storage_disallow_volume_from_snapshot.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/storage/mgc_storage_disallow_volume_from_snapshot.rego)
---

## MGC.STORAGE.006: Disallow public read access on Object Storage Buckets

**Severity:** !!! critical "CRITICAL"

**Category:** `Storage`

**Description:**
Detects 'mgc_object_storage_buckets' that allow public read access.

**Source Code:** [mgc_storage_deny_public_read.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/storage/mgc_storage_deny_public_read.rego)
---

## MGC.STORAGE.007: Disallow public write access on Object Storage Buckets

**Severity:** !!! critical "CRITICAL"

**Category:** `Storage`

**Description:**
Detects 'mgc_object_storage_buckets' that allow public write access.

**Source Code:** [mgc_storage_deny_public_write.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/storage/mgc_storage_deny_public_write.rego)
---

## MGC.STORAGE.008: Ensure versioning is enabled on Object Storage Buckets

**Severity:** !!! warning "MEDIUM"

**Category:** `Storage`

**Description:**
Detects 'mgc_object_storage_buckets' that do not have 'enable_versioning = true'.

**Source Code:** [mgc_storage_enforce_bucket_versioning.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/storage/mgc_storage_enforce_bucket_versioning.rego)
---

