# Welcome to the Magalu Cloud Pratices

This site provides a comprehensive, community-driven collection of security policies for **Magalu Cloud**, implemented as *Policy-as-Code*.

Our goal is to translate the official [Magalu Cloud Security Best Practices](https://docs.magalu.cloud/docs/security/bestpractices/) into automated, enforceable rules. This allows development and operations teams to validate their infrastructure-as-code against recommended security controls before deployment.

All policies are written in **Rego**, the policy language for the Open Policy Agent (OPA), and are designed to be used with tools like **Conftest** to validate Terraform plans.

!!! abstract "From Best Practices to Enforceable Code"
    The official Magalu Cloud documentation provides essential guidance on securing your cloud environment. This project takes that guidance a step further by providing the **code** to automatically check for compliance, bridging the gap between documentation and implementation.

!!! info "Community Driven"
    This is an open-source project, and contributions are welcome! Please see the `CONTRIBUTING.md` file in our [GitHub repository](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices) for details on how to contribute.

---

## Getting Started

To explore the security controls, use the **"Policies"** menu in the navigation bar above. The policies are organized by service category.

### How to Use These Policies

These policies are designed to be integrated directly into your CI/CD pipelines to provide automated security feedback on your Terraform code.

1.  **Explore the Policies:** Use the navigation menu to browse the rules. Each policy page provides a description of the risk, its severity, and a link to the source code.

2.  **Integrate with Conftest:** You can use this repository to test your Terraform plans against the official best practices.

    ```bash
    # 1. Generate a Terraform plan in JSON format
    terraform plan -out=tfplan.binary
    terraform show -json tfplan.binary > tfplan.json

    # 2. Run Conftest against the plan using all policies
    conftest test --policy path/to/magalu-cloud-security-pratices/policy/rego/mgc/ tfplan.json
    ```

    A non-zero exit code indicates that one or more security policies have been violated, which can be used to fail a pipeline build.