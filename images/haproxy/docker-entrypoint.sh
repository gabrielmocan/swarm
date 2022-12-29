#!/usr/bin/env bash
set -e

# exporta variáveis de ambiente
CONFPATH="/usr/local/etc/haproxy/haproxy.cfg"
export HAPROXY_MAXCONN="${HAPROXY_MAXCONN:-100}"
export HAPROXY_MODE="${HAPROXY_MODE:-tcp}"
export HAPROXY_RETRIES="${HAPROXY_RETRIES:-3}"
export HAPROXY_TIMEOUT_CONNECT="${HAPROXY_TIMEOUT_CONNECT:-3s}"
export HAPROXY_TIMEOUT_CHECK="${HAPROXY_TIMEOUT_CHECK:-5s}"
export HAPROXY_TIMEOUT_CLIENT="${HAPROXY_TIMEOUT_CLIENT:-30s}"
export HAPROXY_TIMEOUT_SERVER="${HAPROXY_TIMEOUT_SERVER:-30s}"
export HAPROXY_LISTEN_PORT="${HAPROXY_LISTEN_PORT:-5000}"
export HAPROXY_APP_NAME="${HAPROXY_APP_NAME:-app}"
export HAPROXY_BACKEND_NODES="${HAPROXY_BACKEND_NODES:-}"

# prepara o arquivo haproxy.cfg com os clusters listados
IFS=","
COUNTER=1
read -a backends <<< "$HAPROXY_BACKEND_NODES"
for node in ${backends[*]}; do
    echo "	server node"$COUNTER" "$node" maxconn 100 check" >> $CONFPATH
    let COUNTER++
done

# ajusta as demais configurações alternativas
sed -i "s/	maxconn.*/	maxconn "$HAPROXY_MAXCONN"/" $CONFPATH
sed -i "0,/	mode.*/s//	mode "$HAPROXY_MODE"/" $CONFPATH
sed -i "s/	retries.*/	retries "$HAPROXY_RETRIES"/" $CONFPATH
sed -i "s/	timeout connect.*/	timeout connect "$HAPROXY_TIMEOUT_CONNECT"/" $CONFPATH
sed -i "s/	timeout check.*/	timeout check "$HAPROXY_TIMEOUT_CHECK"/" $CONFPATH
sed -i "s/	timeout client.*/	timeout client "$HAPROXY_TIMEOUT_CLIENT"/" $CONFPATH
sed -i "s/	timeout server.*/	timeout server "$HAPROXY_TIMEOUT_SERVER"/" $CONFPATH
sed -i "s/	bind \*:5000/	bind \*:"$HAPROXY_LISTEN_PORT"/" $CONFPATH
sed -i "s/app/"$HAPROXY_APP_NAME"/" $CONFPATH

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- haproxy "$@"
fi

if [ "$1" = 'haproxy' ]; then
	shift # "haproxy"
	# if the user wants "haproxy", let's add a couple useful flags
	#   -W  -- "master-worker mode" (similar to the old "haproxy-systemd-wrapper"; allows for reload via "SIGUSR2")
	#   -db -- disables background mode
	set -- haproxy -W -db "$@"
fi

exec "$@"
