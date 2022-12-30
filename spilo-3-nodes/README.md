# Variables needed for deployment
```text
SCOPE
TZ
S3_ACCESS_KEY
S3_SECRET_KEY
S3_ENDPOINT
S3_BUCKET
DB_HOSTNAME_01
DB_HOSTNAME_02
DB_HOSTNAME_03
```
# pgbouncer considerations
- pgbouncer.ini stores database connection strings, edit it accordingly before deployment;
- userlist.txt stores pgbouncer users which will have access to the databases, this will "proxy" the password, being handy for access control. Edit it accordingly before deployment;
- if any of those files need to be edited after deployment, simply alter the field "name" in config section and give a new name to the config, that way docker will update configs.
```yaml
configs:
  pgbouncer-conf:
    file: ./pgbouncer.ini
    name: pgbouncer-conf-v2
  pgbouncer-userlist:
    file: ./userlist.txt
    name: pgbouncer-userlist-v2
```
# pgpool considerations
- pgpool PGPOOL_POSTGRES_CUSTOM_USERS and PGPOOL_POSTGRES_CUSTOM_PASSWORDS variables has to match the users and passwords created on pgbouncer.ini file.
```yaml
PGPOOL_POSTGRES_CUSTOM_USERS: user1,user2...
PGPOOL_POSTGRES_CUSTOM_PASSWORDS: pass1,pass2...
```
# Deployment
You need to export them before stack deploy. e.g:
```bash
export SCOPE=spilo
export TZ=America/Recife
export S3_ACCESS_KEY=myaccesskey
export S3_SECRET_KEY=mysecretkey
export S3_ENDPOINT=s3.example.com
export S3_BUCKET=my-bucket
export DB_HOSTNAME_01=DB_NODE_01
export DB_HOSTNAME_02=DB_NODE_02
export DB_HOSTNAME_03=DB_NODE_03

docker stack deploy -c spilo.yml spilo
```
# Bootstraping from previous backup
In case of disaster, one can bootstrap cluster from previous S3 backup. To do so, uncomment the CLONE_ lines in the beggining of stack file and deploy the stack.
```yaml
x-client_data: &client_data
  SCOPE: ${SCOPE?Variable not set}
  TZ: ${TZ?Variable not set}
  CLONE_METHOD: CLONE_WITH_WALE
  CLONE_SCOPE: ${CLONE_SCOPE?Variable not set}
```
- CLONE_SCOPE has to match with the SCOPE that will be bootstraped from;
- To bootstrap from different timeline, alter CLONE_TIMELINE variable. Default is _latest_.
# In-place pg_upgrade
Spilo provides built-in process of doing in-place upgrade. To do so, step up PGVERSION variable, re-deploy stack and execute the following command on master node:
```bash
su -c "python3 /scripts/inplace_upgrade.py $NODE_COUNT" postgres
```
Where NODE_COUNT is the number of nodes in the cluster.
