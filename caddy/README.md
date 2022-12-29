# Minimum viable deployment example

## Variables needed for deployment
```text
EMAIL
CF_API_TOKEN # if using Cloudflare's DNS-01 challenge
```

## External networks needed for deployment
We gonna need to create an external network for Caddy and the services which are going to be exposed later on.
```bash
docker network create --driver overlay caddy
```

## Deployment steps

- NOTE: to enable Cloudflare's DNS-01 challenge, one must uncomment caddy_0.acme_dns label on the stack file!
```yaml
labels:
  # Set ACME definitions
  caddy_0.email: ${EMAIL?Variable not set}  # Set valid e-mail for SSL cert auto-generation
  # Uncomment the line below to enable Cloudflare's DNS-01 TLS challenge, which does not need any open ports
  caddy_0.acme_dns: "cloudflare ${CF_API_TOKEN?Variable not set}"
```
Deploying:
```bash
export EMAIL=johndoe@example.com
export CF_API_TOKEN=cloudflaresAPItoken # if using Cloudflare's DNS-01 challenge

docker stack deploy -c caddy_single.yml caddy_single
```
