DOCS_SRC_DIR   = .
DOCS_BUILD_DIR = public/

all: docs

.PHONY: docs
docs:
	sphinx-build -M html $(DOCS_SRC_DIR) $(DOCS_BUILD_DIR)

auto: ## Hot reloading
	sphinx-autobuild -b html $(DOCS_SRC_DIR) $(DOCS_BUILD_DIR)
