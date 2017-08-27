NPM = $(shell which npm)

BUILD_DIR = dist

build:
	$(NPM) run build -- -p

clean:
	rm -rf $(BUILD_DIR)

clean-all: clean
	rm -rf elm-stuff
	rm -rf tests/elm-stuff

test:
	$(NPM) run test

server:
	$(NPM) run dev
