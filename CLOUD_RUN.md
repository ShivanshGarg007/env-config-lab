# Cloud Run Mapping

The image contains application code only. Cloud Run supplies configuration at runtime.

## Non-secret configuration

Use `--set-env-vars` for non-sensitive values:

```bash
gcloud run deploy SERVICE_NAME \
  --image IMAGE_URL \
  --region REGION \
  --set-env-vars LOG_LEVEL=info,PORT=8080
```

## Secrets

Store API keys and credentials in Secret Manager and expose them with `--set-secrets`:

```bash
gcloud run deploy SERVICE_NAME \
  --image IMAGE_URL \
  --region REGION \
  --set-secrets API_KEY=api-key:latest
```

If `DATABASE_URL` contains credentials, store the complete connection string as a
Secret Manager secret too:

```bash
gcloud run deploy SERVICE_NAME \
  --image IMAGE_URL \
  --region REGION \
  --set-secrets API_KEY=api-key:latest,DATABASE_URL=database-url:latest \
  --set-env-vars LOG_LEVEL=info,PORT=8080
```

Use `--set-env-vars DATABASE_URL=...` only if the URL contains no sensitive data.
Grant the Cloud Run service identity access to the referenced Secret Manager secrets.

## Local Docker equivalent

- Non-secret configuration: `docker run --env-file .env ...`
- Secrets: `docker run -e API_KEY="$API_KEY" ...`
- Keep `.env` ignored by Git and commit only placeholder values in `.env.example`.
- Never bake secrets into Dockerfile `ENV` or `ARG` instructions.
