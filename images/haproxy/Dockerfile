FROM haproxy:2.7.1

COPY docker-entrypoint.sh /usr/local/bin/

COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg

USER 0

RUN chown -R haproxy:haproxy /usr/local/etc/haproxy

USER haproxy
