# https://github.com/darinmorrison/docker-haskell/tree/docker-library
FROM haskell:7.10

# update package repository
RUN apt-get update && \
    apt-get install -y git libpq-dev
RUN cabal update

# Make sure our app directory exists
RUN mkdir -p /opt/auth-server
# Set the base directory of the following RUN statements
WORKDIR /opt/auth-server

### 1.0 dependencies
RUN git clone https://github.com/snapframework/io-streams-haproxy.git /opt/deps/io-streams-haproxy
RUN git clone https://github.com/snapframework/snap.git /opt/deps/snap
RUN git clone https://github.com/snapframework/snap-core.git /opt/deps/snap-core
RUN git clone https://github.com/snapframework/snap-server.git /opt/deps/snap-server
RUN git clone https://github.com/snapframework/snap-loader-static.git /opt/deps/snap-loader-static
RUN git clone https://github.com/snapframework/heist.git /opt/deps/heist
RUN git clone https://github.com/mightybyte/snaplet-postgresql-simple.git /opt/deps/snaplet-postgres-simple
RUN cd /opt/deps/snaplet-postgres-simple && git checkout 1.0

# Create Sandbox and Add Source Deps
RUN cabal sandbox init &&\
    cabal sandbox add-source /opt/deps/io-streams-haproxy &&\
    cabal sandbox add-source /opt/deps/snap &&\
    cabal sandbox add-source /opt/deps/snap-core &&\
    cabal sandbox add-source /opt/deps/snap-server &&\
    cabal sandbox add-source /opt/deps/snap-loader-static &&\
    cabal sandbox add-source /opt/deps/heist &&\
    cabal sandbox add-source /opt/deps/snaplet-postgres-simple

### END 1.0 dependencies

# Make sure log directories exist
RUN mkdir -p /var/log/auth-server

# Create Sandbox
#RUN cabal sandbox init

# Install Dependencies into sandbox. Each command is cached by Docker
# so we don't have to reinstall everything unless we make changes to
# our .cabal file.
COPY ./auth-server.cabal /opt/auth-server/auth-server.cabal
RUN cabal install --only-dependencies -j4 --allow-newer

# Add Application Code
COPY ./src /opt/auth-server/src

# Build Application
RUN cabal build

# COPY assets and misc files into image
COPY ./snaplets /opt/auth-server/snaplets
COPY ./static /opt/auth-server/static
COPY ./.ghci /opt/auth-server/.ghci

# By default, run our application when running a container based on
# this image. Use command line flags to specify log directories.
CMD ["/opt/auth-server/dist/build/auth-server/auth-server",\
     "--access-log", "/var/log/auth-server/access.log",\
     "--error-log", "/var/log/auth-server/error.log"]
