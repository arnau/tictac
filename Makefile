NPM = $(shell which npm)
NPM_PATH = node_modules/.bin/
WEBPACK = $(join $(NPM_PATH), webpack)
WEBPACK_SERVER = $(join $(NPM_PATH), webpack-dev-server)
ELM_TEST = $(join $(NPM_PATH), elm-test)
ELM_FORMAT = $(join $(NPM_PATH), elm-format)


BUILD_DIR = dist

build:
	$(WEBPACK) -p

install:
	$(NPM) install

clean:
	rm -rf $(BUILD_DIR)

clean-all: clean
	rm -rf elm-stuff
	rm -rf tests/elm-stuff

test:
	$(ELM_TEST)

server:
	$(WEBPACK_SERVER) --port 3000

watch:
	$(WEBPACK) --watch

format:
	$(ELM-FORMAT) --yes src
