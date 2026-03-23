# Makefile — local linting and validation helpers
# Usage:
#   make lint          run all linters
#   make shellcheck    shellcheck on all .zsh files
#   make yamllint      yamllint on all .yml files
#   make markdownlint  markdownlint on all .md files
#   make pre-commit    run all pre-commit hooks against every file
SH_FILES    := $(shell find . -name '*.sh' -not -path './.git/*')
YAML_FILES   := $(shell find . -name 'chromaterm*.yml')
MD_FILES     := $(shell find . -name '*.md' -not -path './.git/*')

XDG_CONFIG_HOME ?= $(HOME)/.config
DEST            ?= $(XDG_CONFIG_HOME)/chromaterm

.PHONY: all clean restart test lint shellcheck yamllint markdownlint checkmake pre-commit install uninstall pull
.DEFAULT: all

all: install restart

pull:
	git pull

install:
	@echo "Installing chromaterm config files to $(DEST)"
	@mkdir -p $(DEST)
	@scripts/install-files.sh "$(YAML_FILES)" "$(DEST)"

uninstall:
	@echo "Removing installed chromaterm config files from $(DEST)"
	@scripts/uninstall-files.sh "$(YAML_FILES)" "$(DEST)"

restart:
	@ct -r

test:
	@echo "No tests defined"

lint: shellcheck yamllint markdownlint checkmake
	@echo ""
	@echo "✓ All checks passed."

shellcheck:
	@echo "→ shellcheck"
	@shellcheck --severity=warning --color=always $(SH_FILES)

yamllint:
	@echo "→ yamllint"
	@yamllint -c .yamllint.yml $(YAML_FILES)

markdownlint:
	@echo "→ markdownlint"
	@markdownlint --config .markdownlint.yml $(MD_FILES)

checkmake:
	@echo "→ checkmake"
	@checkmake --config .checkmake.ini Makefile

pre-commit:
	@echo "→ pre-commit (all files)"
	@pre-commit run --all-files

clean:
	@echo "Cleaning up $(DEST) if empty"
	@scripts/clean-dest.sh "$(DEST)"
