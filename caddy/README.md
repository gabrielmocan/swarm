## Minimum viable deployment example

# Variables needed for deployment
```text
EMAIL
CF_API_TOKEN # if using Cloudflare's DNS-01 challenge
```

# External networks needed for deployment
We gonna need to create an external network for Caddy and the services which are going to be exposed later on.
```bash
docker network create --driver overlay caddy
```

# Deployment steps

- NOTE: to enable Cloudflare's DNS-01 challenge, one must uncomment caddy_0.acme_dns label on the stack file!

```bash
export EMAIL=johndoe@example.com
export CF_API_TOKEN=cloudflaresAPItoken # if using Cloudflare's DNS-01 challenge

docker stack deploy -c caddy_single.yml caddy_single
```
