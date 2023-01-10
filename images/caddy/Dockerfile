# Version to build
ARG CADDY_VERSION="2.6.2"

FROM caddy:${CADDY_VERSION}-builder AS builder

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/caddy-dns/cloudflare               \
    --with github.com/ss098/certmagic-s3                 \
    --with github.com/yroc92/postgres-storage

FROM caddy:${CADDY_VERSION}-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

CMD ["caddy", "docker-proxy"]
