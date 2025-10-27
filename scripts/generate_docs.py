import os
import re
import json
from collections import defaultdict

POLICY_ROOT = "policy/rego/mgc"
DOCS_OUTPUT_DIR = "docs/policies"

# Mapeamento de IDs especiais para avisos customizados
SPECIAL_NOTICES = {
    "MGC.VM.001": """
!!! warning "Pending Provider Enhancement"
    This policy targets a `write-only` attribute (`allocate_public_ipv4`) in the Terraform provider. 
    Static analysis tools like Conftest may not be able to reliably detect this attribute in the generated plan file (`tfplan.json`). 
    Full enforcement of this policy is pending a provider update to make this attribute consistently visible in the plan's output.
"""
}

def parse_rego_metadata(file_path):
    """Parses a .rego file to extract the __rego_metadata__ block."""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        metadata_match = re.search(r'__rego_metadata__\s*:=\s*(\{.*?\})', content, re.DOTALL)
        if not metadata_match:
            return None
        
        # Simple conversion from Rego map-like syntax to JSON
        metadata_str = metadata_match.group(1).replace(';', ',')
        metadata_dict = json.loads(metadata_str)
        metadata_dict['filepath'] = file_path.replace("\\", "/") # Normalize path separators
        return metadata_dict
    except Exception as e:
        print(f"Error parsing metadata from {file_path}: {e}")
        return None

def generate_policy_markdown(policy_data):
    """Generates the Markdown content for a single policy."""
    severity_map = {
        "CRITICAL": "critical", "HIGH": "danger",
        "MEDIUM": "warning", "LOW": "info"
    }
    severity_level = policy_data.get("severity", "UNKNOWN").upper()
    severity_admonition = severity_map.get(severity_level, "note")

    md_parts = [
        f"## {policy_data.get('id', 'N/A')}: {policy_data.get('title', 'No Title')}\n",
        f"**Severity:** !!! {severity_admonition} \"{severity_level}\"\n",
        f"**Category:** `{policy_data.get('category', 'Uncategorized')}`\n",
        f"**Description:**\n{policy_data.get('description', 'No description provided.')}\n"
    ]

    # Add special notice if the policy ID is in our map
    if policy_data.get('id') in SPECIAL_NOTICES:
        md_parts.append(f"{SPECIAL_NOTICES[policy_data.get('id')]}\n")

    # The repo_url will be available in mkdocs, but we use a placeholder for now
    repo_url = "https://github.com/terraform-magalu-cloud/magalu-cloud-security-pratices"
    md_parts.append(f"**Source Code:** [{os.path.basename(policy_data['filepath'])}]({repo_url}/blob/main/{policy_data['filepath']})\n")

    return "\n".join(md_parts)

def main():
    if not os.path.exists(DOCS_OUTPUT_DIR):
        os.makedirs(DOCS_OUTPUT_DIR)

    all_policies = []
    for root, _, files in os.walk(POLICY_ROOT):
        for file in files:
            if file.endswith(".rego"):
                file_path = os.path.join(root, file)
                metadata = parse_rego_metadata(file_path)
                if metadata:
                    all_policies.append(metadata)

    policies_by_category = defaultdict(list)
    for policy in sorted(all_policies, key=lambda p: p.get('id', '')):
        category = policy.get('category', 'Uncategorized').lower().replace(" ", "")
        policies_by_category[category].append(policy)

    print("Generating policy documentation...")
    for category, policies in policies_by_category.items():
        category_md_path = os.path.join(DOCS_OUTPUT_DIR, f"{category}.md")
        with open(category_md_path, 'w', encoding='utf-8') as f:
            title = category.replace("_", " ").title()
            f.write(f"# {title} Policies\n\n")
            
            for policy in policies:
                f.write(generate_policy_markdown(policy))
                f.write("---\n\n")
        print(f"  - Wrote {len(policies)} policies to {category_md_path}")
        
    print("\nDocumentation generation complete.")

if __name__ == "__main__":
    main()