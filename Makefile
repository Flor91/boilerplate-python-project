.EXPORT_ALL_VARIABLES:
.PHONY: venv install pre-commit clean

setup: venv install pre-commit

venv:
	@echo "Creating .venv..."
	poetry env use python3.12

install:
	@echo "Installing dependencies..."
	poetry install --no-root --remove-untracked

# Run all checks (test, lint, typecheck)
ci: typecheck lint test
.PHONY: ci

# Run tests
test:
	poetry run pytest .
.PHONY: test

# Run linting
lint:
	poetry run black --check .
	poetry run isort -c .
	poetry run flake8 .
	poetry run pydocstyle .
.PHONY: lint

# Run autoformatters
lint-fix:
	poetry run black .
	poetry run isort .
.PHONY: lint-fix

# Run typechecking
typecheck:
	poetry run mypy --show-error-codes --pretty .
.PHONY: typecheck

# Define default goal and provide help message
.DEFAULT_GOAL := help
help: Makefile
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "    \033[32m%-20s\033[0m %s\n", $$1, $$2}'
