FROM bitnami/pgbouncer:1

USER 0

ARG APT_FLAGS_COMMON="-qq -y"
ARG APT_FLAGS_PERSISTANT="${APT_FLAGS_COMMON} --no-install-recommends"

# Installs postgresql-client to add pg_isready to the image
RUN apt ${APT_FLAGS_COMMON} update &&     \
    apt install ${APT_FLAGS_PERSISTANT}   \
        postgresql-client 1>/dev/null &&  \
    apt ${APT_FLAGS_COMMON} autoremove && \
    apt ${APT_FLAGS_COMMON} clean &&      \
    rm -rf /var/lib/apt/lists/*

USER 1001
