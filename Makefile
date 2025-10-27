.PHONY: test
test: ## Run all conftest policy tests against the test cases
	@echo "Executing all policy test cases..."
	@cd test && ./run_tests.sh

.PHONY: test-clean
test-clean: ## Clean up ONLY Terraform artifacts from test case directories
	@echo "Cleaning up test artifacts from ./test/cases/..."
	
	# Encontra e remove recursivamente APENAS o diretório '.terraform'
	@find ./test/cases -type d -name ".terraform" -print -exec rm -rf {} +
	
	# Encontra e remove recursivamente APENAS o arquivo '.terraform.lock.hcl'
	@find ./test/cases -type f -name ".terraform.lock.hcl" -print -delete
	
	# Encontra e remove recursivamente APENAS o arquivo 'tfplan.binary'
	@find ./test/cases -type f -name "tfplan.binary" -print -delete
	
	# Encontra e remove recursivamente APENAS o arquivo 'tfplan.json'
	@find ./test/cases -type f -name "tfplan.json" -print -delete
	
	@echo "Test artifacts cleaned."

.PHONY: docs-deps
docs-deps: ## Install dependencies for documentation (mkdocs)
	@echo "Installing MkDocs dependencies..."
	@pip install mkdocs mkdocs-material

.PHONY: docs-gen
docs-gen: ## Generate policy markdown files from .rego metadata
	@echo "Generating documentation from Rego files..."
	@python3 scripts/generate_docs.py

.PHONY: docs-serve
docs-serve: docs-gen ## Generate and serve the documentation locally for development
	@echo "Serving documentation at http://127.0.0.1:8000"
	# Este comando inicia o servidor no endereço correto e é a forma recomendada.
	@mkdocs serve --dev-addr 127.0.0.1:8000

.PHONY: docs-build
docs-build: docs-gen ## Generate and build the static site for deployment
	@echo "Building static site in ./site directory..."
	@mkdocs build