# Virtualmachine Policies

## MGC.VM.001: Disallow public IP allocation on VM instances

**Severity:** !!! danger "HIGH"

**Category:** `Virtual Machine`

**Description:**
Detects 'mgc_virtual_machine_instances' that are configured to allocate a public IP on boot.


!!! warning "Pending Provider Enhancement"
    This policy targets a `write-only` attribute (`allocate_public_ipv4`) in the Terraform provider. 
    Static analysis tools like Conftest may not be able to reliably detect this attribute in the generated plan file (`tfplan.json`). 
    Full enforcement of this policy is pending a provider update to make this attribute consistently visible in the plan's output.


**Source Code:** [mgc_vm_disallow_public_ip.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/vm/mgc_vm_disallow_public_ip.rego)
---

## MGC.VM.002: Ensure VM instances explicitly define Security Groups

**Severity:** !!! warning "MEDIUM"

**Category:** `Virtual Machine`

**Description:**
Detects 'mgc_virtual_machine_instances' that do not define 'creation_security_groups', resulting in using the VPC default.

**Source Code:** [mgc_vm_ensure_explicit_security_group.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/vm/mgc_vm_ensure_explicit_security_group.rego)
---

## MGC.VM.003: Ensure non-Windows VM instances have an associated SSH Key

**Severity:** !!! warning "MEDIUM"

**Category:** `Virtual Machine`

**Description:**
Detects non-Windows 'mgc_virtual_machine_instances' that do not define a 'ssh_key_name'.

**Source Code:** [mgc_vm_ensure_ssh_key.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/vm/mgc_vm_ensure_ssh_key.rego)
---

## MGC.VM.004: Disallow manual snapshots of VM instances

**Severity:** !!! info "LOW"

**Category:** `Virtual Machine`

**Description:**
Detects the use of manual VM snapshots ('mgc_virtual_machine_snapshots'). Prefer automated block storage backup schedules.

**Source Code:** [mgc_vm_disallow_manual_snapshots.rego](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/blob/main/policy/rego/mgc/vm/mgc_vm_disallow_manual_snapshots.rego)
---

