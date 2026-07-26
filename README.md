# eve-fixer-demo

App Rails mínima que sirve de campo de pruebas para el agente fixer.

```bash
cp .env-sample .env
cp docker-compose.override.yml-sample docker-compose.override.yml
docker compose up -d
docker compose exec -T app sh -lc 'bin/rails db:test:prepare && bin/rails test'
```

El gate completo es `bash scripts/verify.sh`.
