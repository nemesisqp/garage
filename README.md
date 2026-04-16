# garage
Garage S3 with my default config file

# docker-compose.yml (simple deploy)
```yml
services:
  garage:
    image: ghcr.io/nemesisqp/garage:latest
    container_name: garage
    volumes:
      - garage-data:/var/lib/garage
    restart: unless-stopped
    # ports:
    #   - 3900:3900
    #   - 3902:3902
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

# docker-compose.yml (deploy with custom local data path)
```yaml
services:
  garage:
    image: dxflrs/garage:v2.3.0
    container_name: garage
    volumes:
      - ./garage.toml:/etc/garage.toml
      - /CUSTOM-garage-data:/var/lib/garage
    restart: unless-stopped
    # ports:
    #   - 3900:3900
    #   - 3902:3902
    environment:
      - 'GARAGE_ADMIN_TOKEN=${GARAGE_ADMIN_TOKEN}'
      - 'GARAGE_METRICS_TOKEN=${GARAGE_METRICS_TOKEN}'
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
      - API_BASE_URL="http://garage:3903"
      - S3_ENDPOINT_URL="http://garage:3900"
      - S3_REGION="garage"
      - API_ADMIN_KEY=${GARAGE_ADMIN_TOKEN}
```

# release for git CI build
```bash
TAG="v2.3.0"

git add .
git commit -m "$TAG"
git tag $TAG
git push
git push origin $TAG
```

# rollback failed tag and repush
```bash
TAG="v2.3.0"
git push origin --delete $TAG
git tag -d $TAG
git add .
git commit -m "$TAG"
git tag $TAG
git push
git push origin $TAG

```