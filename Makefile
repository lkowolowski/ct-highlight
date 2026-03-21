# Makefile — local linting and validation helpers
# Usage:
#   make lint          run all linters
#   make shellcheck    shellcheck on all .zsh files
#   make zsh-check     zsh -n syntax check on all .zsh files
#   make yamllint      yamllint on all .yml files
#   make markdownlint  markdownlint on all .md files
#   make pre-commit    run all pre-commit hooks against every file

SH_FILES    := $(shell find . -name '*.sh' -not -path './.git/*')
YAML_FILES   := $(shell find . -name '*.yml' -not -name '.pre-commit-config.yaml' -not -path './.git/*')
MD_FILES     := $(shell find . -name '*.md' -not -path './.git/*')

# Copy files into place and reload ct so any running processes pick up the change
#
DESTDIR = ${HOME}/.config/chromaterm
INSTALL = install
INSTALL_PROGRAM = $(INSTALL)
INSTALL_OPTS = -pSv -m 644

.PHONY: all clean restart test lint
.DEFAULT: all

all: build install restart

pull:
	git pull

build:
	@./generate_conf.sh

install: build
	@$(INSTALL_PROGRAM) -d $(DESTDIR)
	$(INSTALL_PROGRAM) $(INSTALL_OPTS) chromaterm.yml $(DESTDIR)/chromaterm.yml

restart:
	ct -r

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
	rm -f chromaterm.yml
