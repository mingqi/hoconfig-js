all: clean peg _build/lib package.json README.md

peg: _build/lib
	pegjs parser.pegjs lib/parser.js
	pegjs parser.pegjs _build/lib/parser.js


package.json: _build
	cp package.json _build

README.md: _build
	cp README.md _build

_build/lib: _build
	coffee -c -o _build/lib lib

_build:
	mkdir -p _build

publish: all
	cd _build && npm publish

clean: 
	rm -rf _build