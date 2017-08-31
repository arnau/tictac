NPM = $(shell which npm)
NPM_PATH = node_modules/.bin/
WEBPACK = $(join $(NPM_PATH), webpack)
WEBPACK_SERVER = $(join $(NPM_PATH), webpack-dev-server)
ELM_PACKAGE = $(join $(NPM_PATH), elm-package)
ELM_TEST = $(join $(NPM_PATH), elm-test)
ELM_FORMAT = $(join $(NPM_PATH), elm-format)

BUILD_DIR = dist
EXAMPLE_DIR = docs

build:
	$(WEBPACK) -p

install: PKG =
install:
	$(NPM) install
	$(ELM_PACKAGE) install -y $(PKG)

test:
	$(ELM_TEST)

clean:
	rm -rf $(BUILD_DIR)

clean-test-deps:
	rm -rf tests/elm-stuff

clean-deps:
	rm -rf elm-stuff

clean-all: clean clean-test-deps clean-deps

server:
	$(WEBPACK_SERVER) --port 3000

watch:
	$(WEBPACK) --watch

format:
	$(ELM-FORMAT) --yes src

# Compiles and sets a new version of the example for github pages.
example: build
	rm -rf $(EXAMPLE_DIR)
	cp -R $(BUILD_DIR) $(EXAMPLE_DIR)
