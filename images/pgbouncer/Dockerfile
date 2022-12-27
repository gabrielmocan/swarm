FROM bitnami/pgbouncer:1

# This bin and lib will enable healthchecks using pg_isready
COPY ./pg_isready/pg_isready /opt/bitnami/postgresql/bin/
COPY ./pg_isready/libpq.so.5.15 /usr/lib/x86_64-linux-gnu/libpq.so.5
