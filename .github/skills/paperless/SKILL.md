---
name: paperless
description: Starts and stops a local Paperless-ngx stack (PostgreSQL, Redis, Gotenberg, Tika, and Paperless AI) with Docker Compose. Use this skill when the user asks to start Paperless or to manage/OCR documents locally. Exposes Paperless-ngx on http://localhost:8000 and Paperless AI on http://localhost:3000.
license: Apache-2.0
metadata:
  author: sualeh
  version: "1.0"
compatibility: Requires Docker and Docker Compose installed on the host.
---
# Paperless-ngx Skill

Skill location: `.github/skills/paperless`

This skill starts and stops the Paperless-ngx stack locally with Docker Compose so an AI agent can bring up Paperless when asked to "start Paperless", to ingest/OCR documents, or to use the Paperless AI assistant.

## Files

- `compose.yaml`: Compose definition exposing Paperless-ngx on http://localhost:8000 and Paperless AI on http://localhost:3000
- `paperless.env.example`: Example env file; copy to `paperless.env` and set `PAPERLESS_SECRET_KEY`
- `start-paperless.sh` / `start-paperless.ps1`: Start the stack with `docker compose up -d`
- `stop-paperless.sh` / `stop-paperless.ps1`: Stop and remove the stack with `docker compose down`

## Usage (agent or human)

1) Copy `paperless.env.example` to `paperless.env` and set a strong `PAPERLESS_SECRET_KEY` (plus timezone/OCR language if needed).
2) Start (PowerShell): `./start-paperless.ps1`
3) Start (Bash): `./start-paperless.sh`
4) Stop (PowerShell): `./stop-paperless.ps1`
5) Stop (Bash): `./stop-paperless.sh`

Append `-DryRun` (PowerShell) or `--dry-run` (Bash) to see the Compose command without running it.

After starting:
- Paperless-ngx UI: http://localhost:8000
- Paperless AI (chat assistant): http://localhost:3000

## Agent Instructions

When the user asks to start Paperless-ngx, or to ingest/manage/OCR documents with Paperless, ensure `paperless.env` exists (copy from the example and set `PAPERLESS_SECRET_KEY`). Run the start script from this folder, then share the Paperless UI and Paperless AI URLs. Use the stop script to tear down containers when done.

## References

- [Paperless-ngx Documentation](https://docs.paperless-ngx.com/)
- [Paperless-ngx GitHub Repository](https://github.com/paperless-ngx/paperless-ngx)
- [Docker Hub - Paperless-ngx](https://hub.docker.com/r/paperlessngx/paperless-ngx)
- [Paperless AI GitHub Repository](https://github.com/clusterzx/paperless-ai)
