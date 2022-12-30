# Wordpress
This stack will deploy Wordpress with MariaDB and will produce S3 backups at midnight localtime (configurable through labels).
## Prerequisites
- **Caddy** as reverse proxy for docker swarm. 
- **Cronjobs** as task scheduler for docker swarm.
## Variables needed for deployment
```text
SCOPE
TZ
DB_USERNAME
DB_PASSWORD
DB_DATABASE
DB_ROOT_PASSWORD
S3_ACCESS_KEY
S3_SECRET_KEY
S3_ENDPOINT
S3_BUCKET
```
## Deployment
You need to export them before stack deploy. e.g:
```bash
export SCOPE=spilo
export TZ=America/Recife
export DB_USERNAME=wordpress
export DB_PASSWORD=wordpress_password
export DB_DATABASE=wordpress
export DB_ROOT_PASSWORD=wordpress_root_password
export S3_ACCESS_KEY=myaccesskey
export S3_SECRET_KEY=mysecretkey
export S3_ENDPOINT=s3.example.com
export S3_BUCKET=my-bucket

docker stack deploy -c wordpress.yml wordpress
```
