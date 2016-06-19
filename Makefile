prepare:
	cabal update
	cabal install cabal-install
	cabal sandbox init
.PHONY: prepare

build:
	cabal install --only-dependencies
	cabal configure
	cabal build
	cabal install
.PHONY: build

run:
	cabal run
.PHONY: run

clean:
	rm -f *.o *.hi
	rm -rf dist
.PHONY: clean
