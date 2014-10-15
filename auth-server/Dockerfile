# https://github.com/darinmorrison/docker-haskell/tree/docker-library
FROM haskell:7.8

RUN cabal update

# Add Cabal File and deps/ folder
ADD ./auth-server.cabal /opt/auth-server/auth-server.cabal
ADD ./deps /opt/auth-server/deps

# Create Sandbox and Add Source Deps
RUN cd /opt/auth-server &&\
        cabal sandbox init &&\
        cabal sandbox add-source deps/io-streams-haproxy &&\
        cabal sandbox add-source deps/snap &&\
        cabal sandbox add-source deps/snap-core &&\
        cabal sandbox add-source deps/snap-server &&\
        cabal sandbox add-source deps/snap-loader-static &&\
        cabal sandbox add-source deps/heist

RUN cd /opt/auth-server && cabal install --only-dependencies

# Explicitly add relevant folders
ADD ./src /opt/auth-server/src
ADD ./snaplets /opt/auth-server/snaplets
ADD ./static /opt/auth-server/static

# Init logging directories
RUN mkdir /opt/auth-server/log

# Build the Project
RUN cd /opt/auth-server && cabal build

# The directory CMD works from
WORKDIR /opt/auth-server
CMD ["./dist/build/auth-server/auth-server"]
