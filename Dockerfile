FROM alpine:latest as unzipper
RUN apk add unzip wget curl
ARG VERSION
WORKDIR /pg_repack

# RUN curl -O /pg_repack.zip https://api.pgxn.org/dist/pg_repack/${VERSION}/pg_repack-${VERSION}.zip
COPY pg_repack-${VERSION}.zip /pg_repack.zip
RUN unzip /pg_repack.zip "pg_repack-${VERSION}/*" -d . && mv pg_repack-${VERSION}/* . && rm -r pg_repack-${VERSION}

FROM debian:bookworm-slim as builder
ARG PG_VERSION

RUN apt-get update && \
  apt-get install -y wget gnupg && \
  sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt bookworm-pgdg main" > /etc/apt/sources.list.d/pgdg.list' && \
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
  apt-get update && \
  apt-get install -y postgresql-server-dev-${PG_VERSION} postgresql-common postgresql-client-${PG_VERSION} make gcc libz-dev libzstd-dev liblz4-dev libreadline-dev
COPY --from=unzipper /pg_repack/ /pg_repack/
WORKDIR /pg_repack

RUN make

FROM debian:bookworm-slim
ARG PG_VERSION

RUN apt-get update && \
  apt-get install -y wget gnupg && \
  sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt bookworm-pgdg main" > /etc/apt/sources.list.d/pgdg.list' && \
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
  useradd pg_repack && \
  apt-get update && \
  apt-get install -y postgresql-client-${PG_VERSION}

COPY --from=builder /pg_repack/bin/pg_repack /usr/bin/pg_repack
USER pg_repack

ENTRYPOINT [ "pg_repack" ]
