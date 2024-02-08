.EXPORT_ALL_VARIABLES:
.PHONY: venv install pre-commit clean

setup: venv install pre-commit

venv:
	@echo "Creating .venv..."
	poetry env use python3.12

install:
	@echo "Installing dependencies..."
	poetry install --no-root --remove-untracked

# Makefile
format-black:
	@black .

format-isort:
	@isort .

lint-black:
	@black . --check

lint-isort:
	@isort . --check

lint-flake8:
	@flake8 .

lint-mypy:
	@mypy ./src

lint-mypy-report:
	@mypy ./src --html-report ./mypy_html

format: format-black format-isort
lint: lint-black lint-isort lint-flake8 lint-mypy
