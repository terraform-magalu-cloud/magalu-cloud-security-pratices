# Magalu Cloud Security Practices

[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/terraform-magalu-cloud/magalu-cloud-security-pratices?style=for-the-badge&sort=semver)](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/releases)
[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/terraform-magalu-cloud/magalu-cloud-security-pratices/ci.yml?branch=main&style=for-the-badge)](https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices/actions)
[![License](https://img.shields.io/github/license/terraform-magalu-cloud/magalu-cloud-security-pratices?style=for-the-badge)](./LICENSE)

Welcome to the **Magalu Cloud Security Hub** repository! This project provides a comprehensive, community-driven collection of security policies for **Magalu Cloud**, implemented as *Policy-as-Code*.

Our goal is to translate the official [Magalu Cloud Security Best Practices](https://docs.magalu.cloud/docs/security/bestpractices/) into automated, enforceable rules. This allows development and operations teams to validate their Terraform infrastructure-as-code against recommended security controls **before deployment**, shifting security left in the development lifecycle.

:blue_book: **[Explore the full documentation and all policies on our website.](https://terraform-magalu-cloud.github.io/magalu-cloud-security-pratices/)**

---

## What is This?

This repository contains a suite of policies written in **Rego**, the policy language for the [Open Policy Agent (OPA)](https://www.openpolicyagent.org/). These policies are designed to be used with tools like [Conftest](https://www.conftest.dev/) to statically analyze Terraform plan files.

By integrating these checks into your CI/CD pipeline, you can automatically:
- :mag: **Detect** misconfigurations that violate security best practices.
- :lock: **Prevent** insecure infrastructure from being deployed.
- :rocket: **Accelerate** security reviews by codifying your guardrails.
- :books: **Educate** developers on secure patterns for Magalu Cloud.

## Quick Start

You can use these policies to test your local Terraform plans in a few simple steps.

### Prerequisites
- [Terraform](https://developer.hashicorp.com/terraform/downloads) (v1.0.0+)
- [Conftest](https://www.conftest.dev/install/) (v0.25.0+)

### Usage

1.  **Clone this repository:**
    ```bash
    git clone https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices.git
    cd magalu-cloud-security-pratices
    ```

2.  **Generate a Terraform Plan:**
    Navigate to your own Terraform project directory and create a plan file in JSON format.
    ```bash
    # In your project's directory
    terraform plan -out=tfplan.binary
    terraform show -json tfplan.binary > tfplan.json
    ```

3.  **Run Conftest:**
    Execute `conftest` against your plan file, pointing the `--policy` flag to the `policy/rego/mgc` directory you cloned.
    ```bash
    conftest test --policy /path/to/magalu-cloud-security-pratices/policy/rego/mgc/ tfplan.json
    ```
    
    A non-zero exit code indicates that one or more security policies have been violated.

## CI/CD Integration

The primary goal of this project is to be integrated into your CI/CD pipeline. Here is a basic example for **GitHub Actions**:

```yaml
name: Terraform Plan Security Check

on:
  pull_request:
    branches: [ main ]

jobs:
  conftest-check:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout main repository
        uses: actions/checkout@v4

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v3

      - name: Terraform Init
        run: terraform init

      - name: Terraform Plan
        run: |
          terraform plan -out=tfplan.binary
          terraform show -json tfplan.binary > tfplan.json

      - name: Checkout Security Policies Repository
        uses: actions/checkout@v4
        with:
          repository: terraform-magalu-cloud/magalu-cloud-security-pratices
          path: './security-policies'
      
      - name: Install Conftest
        uses: open-policy-agent/setup-opa@v2
        with:
          opa-version: latest

      - name: Run Conftest Scan
        run: conftest test --policy ./security-policies/policy/rego/mgc/ tfplan.json
```

## Policy Documentation

All policies are fully documented with descriptions, severity ratings, and categories. For a user-friendly view, please visit our **[Security Hub documentation website](https://terraform-magalu-cloud.github.io/magalu-cloud-security-pratices/)**.

## Governance and Community

This project is built for the community and welcomes collaboration. To ensure a healthy and secure development environment, we adhere to the following guidelines:

- **Contributing:** If you want to add or improve a policy, please read our **[Contributing Guide](./CONTRIBUTING.md)**. It contains all the information you need to set up your environment and submit a pull request.
- **Code of Conduct:** All participants are expected to uphold our **[Code of Conduct](./CODE_OF_CONDUCT.md)** to foster a welcoming and inclusive community.
- **Security Policy:** To report a potential security vulnerability in this project, please follow the instructions in our **[Security Policy](./SECURITY.md)**.

## License

This project is licensed under the MIT License - see the **[LICENSE](./LICENSE)** file for details.