# Contributing Guide

First off, thank you for considering contributing to this project! Your help is essential for its success.

This document provides a set of guidelines for contributing. These are mostly guidelines, not rules. Use your best judgment, and feel free to propose changes to this document in a pull request.

## Code of Conduct

This project and everyone participating in it is governed by our [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

## How Can I Contribute?

*   Reporting Bugs
*   Suggesting Enhancements
*   Writing Documentation
*   Submitting Pull Requests with fixes or new features

## Setting Up the Development Environment

To ensure code consistency and quality, we use `make` to automate dependency installation and common tasks.

### 1. Prerequisites

You will need `git` and `make` installed on your system.

**Linux (Ubuntu/Debian):**
```bash
sudo apt-get update && sudo apt-get install -y make git curl unzip
```

**Linux (Fedora/CentOS):**
```bash
sudo dnf install -y make git curl unzip
```

**Linux (Arch Linux):**
```bash
sudo pacman -Syu --noconfirm make git curl unzip
```

**Linux (OpenSUSE):**
```bash
sudo zypper install -y make git curl unzip
```

**Windows:**
We highly recommend using **WSL 2 (Windows Subsystem for Linux)** with a distribution like Ubuntu for the best experience.

Alternatively, you can use:
*   **Git Bash**: Comes with Git for Windows and includes `make`.
*   **PowerShell**: You can install `make` and other tools via package managers like [Chocolatey](https://chocolatey.org/) or [Scoop](https://scoop.sh/).
    ```powershell
    # Using Chocolatey
    choco install make git
    ```

### 2. Installation and Initialization

After cloning the repository, run the following command in the project root. It will install all necessary tools (`tfenv`, `tflint`, `terraform-docs`, `pre-commit`) and set up the commit hooks.

```bash
make init
```

This command ensures you are using the correct Terraform version and that quality checks are run automatically before each commit.

## Development Workflow

1.  Fork the repository.
2.  Create a new branch from `main`: `git checkout -b feat/your-feature-name`.
3.  Make your changes to the code.
4.  Use `make format` to format the code and documentation.
5.  Stage your files (`git add .`) and commit your changes.
6.  The `pre-commit` hooks will run automatically. If they fail, fix the issues and try committing again.
7.  Push your changes to your fork (`git push origin feat/your-feature-name`).
8.  Open a Pull Request to the original repository.

## Commit Message Standard

We use the **Conventional Commits** standard. This helps us maintain a clear commit history and automate changelog generation.

The commit message should be structured as follows:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

**Common Types:**
*   **feat**: A new feature.
*   **fix**: A bug fix.
*   **docs**: Documentation only changes.
*   **style**: Changes that do not affect the meaning of the code (white-space, formatting, etc).
*   **refactor**: A code change that neither fixes a bug nor adds a feature.
*   **perf**: A code change that improves performance.
*   **test**: Adding missing tests or correcting existing tests.
*   **chore**: Changes to the build process or auxiliary tools and libraries.

**Example:**
```
feat(network): add support for NAT Gateway in VPC module

Implements the mgc_network_nat_gateway resource, allowing the creation
of NAT gateways in private subnets for internet access.
```

### Breaking Changes

For breaking changes, add a `!` after the type/scope, or include a `BREAKING CHANGE:` footer.

**Example with `!`:**
```
refactor(vm)!: rename 'image' variable to 'image_name'

The 'image' variable has been renamed to 'image_name' for clarity
and to avoid conflicts with other resources.

BREAKING CHANGE: The input variable `image` has been removed.
Users must update their configurations to use `image_name`.
```