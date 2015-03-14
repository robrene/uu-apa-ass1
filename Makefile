CABAL-CONFIGURE-FLAGS := --user
CABAL-BUILD-FLAGS     :=

all : haskell symlinks

src/Lang/AG.hs : src/Lang/AG.ag src/Lang/Lang.ag
	uuagc -Hdcfws --self -P src/Lang src/Lang/AG.ag

haskell : src/Lang/AG.hs
	cabal configure $(CABAL-CONFIGURE-FLAGS)
	cabal build $(CABAL-BUILD-FLAGS)

symlinks : haskell
	mkdir -p bin
	ln -fs ../dist/build/parse-lang/parse-lang bin/

clean :
	rm -f src/Lang/AG.hs
	rm -rf dist
	rm -rf bin

repl : haskell
	cabal repl

sandbox:
	cabal sandbox init
	cabal install --dependencies-only

.PHONY : haskell clean sandbox
