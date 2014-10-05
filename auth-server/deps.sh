#! /bin/sh

#  this is for using snap server 1.0, which isn't on hackage yet
mkdir deps

git clone git@github.com:snapframework/io-streams-haproxy.git deps/io-streams-haproxy
git clone git@github.com:snapframework/snap-core.git deps/snap
git clone git@github.com:snapframework/snap-core.git deps/snap-core
git clone git@github.com:snapframework/snap-server.git deps/snap-server
git clone git@github.com:snapframework/snap-loader-static.git deps/snap-loader-static
git clone git@github.com:snapframework/heist.git deps/heist

#git clone git@github.com:snapframework/snap-templates.git deps/snap-templates

#cabal sandbox init

# cabal sandbox add-source deps/io-streams-haproxy
# cabal sandbox add-source deps/snap-core
# cabal sandbox add-source deps/snap-server
# cabal sandbox add-source deps/snap-loader-static
# cabal sandbox add-source deps/heist
