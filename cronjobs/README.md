# Swarm Cronjobs
This stack will enable creating tasks in a time-based schedule. It comes with a "system prune" hourly task.

For more information on this project, please refer to https://crazymax.dev/swarm-cronjob/
# Deployment
```bash
docker stack deploy -c cronjobs.yml cronjobs
```
