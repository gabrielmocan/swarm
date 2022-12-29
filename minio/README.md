# Prerequisites
This deployment assumes you have Caddy up an running as reverse proxy for docker swarm.

# Variables needed for deployment:
```text
ACCESS_KEY
SECRET_KEY
MINIO_HOSTNAME_01
MINIO_HOSTNAME_02
MINIO_HOSTNAME_03
DOMAIN
```
You need to export them before stack deploy. e.g:
```bash
export ACCESS_KEY=myaccesskey
export SECRET_KEY=mysecretkey
export MINIO_HOSTNAME_01=MINIO_NODE_01
export MINIO_HOSTNAME_02=MINIO_NODE_02
export MINIO_HOSTNAME_03=MINIO_NODE_03
export DOMAIN=example.com

docker stack deploy -c minio_ha.yml minio_ha.yml
```
