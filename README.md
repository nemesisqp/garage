# garage
Garage S3 with my default config file

# docker-compose.yml
```yml
services:
  garage:
    image: ghcr.io/nemesisqp/garage:latest
    container_name: garage
    volumes:
      - garage-data:/var/lib/garage
    restart: unless-stopped
    environment:
      - GARAGE_ADMIN_TOKEN=${GARAGE_ADMIN_TOKEN}
      - GARAGE_METRICS_TOKEN=${GARAGE_METRICS_TOKEN}
      - GARAGE_RPC_SECRET=${GARAGE_RPC_SECRET}

  webui:
    image: khairul169/garage-webui:latest
    container_name: garage-webui
    restart: unless-stopped
    volumes:
      - ./garage.toml:/etc/garage.toml:ro
    # ports:
    #   - 3909:3909
    environment:
      - API_BASE_URL: "http://garage:3903"
      - S3_ENDPOINT_URL: "http://garage:3900"
      - S3_REGION: "garage"
      - API_ADMIN_KEY=${GARAGE_ADMIN_TOKEN}
```