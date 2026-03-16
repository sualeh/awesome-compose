# Paperless-ngx Skill

Skill location: .github/skills/paperless.

This skill starts and stops the Paperless-ngx stack (web app, PostgreSQL, Redis, Gotenberg, Tika, and Paperless AI) locally with Docker Compose so an AI agent can bring up Paperless when asked to manage or OCR documents.

## Files

- compose.yaml: Compose definition exposing Paperless-ngx on http://localhost:8000 and Paperless AI on http://localhost:3000
- paperless.env.example: Example environment file; copy to `paperless.env` and set `PAPERLESS_SECRET_KEY`
- start-paperless.sh / start-paperless.ps1: Start the stack with `docker compose up -d`
- stop-paperless.sh / stop-paperless.ps1: Stop and remove the stack with `docker compose down`

## Usage (agent or human)

- Copy paperless.env.example to paperless.env and set a strong `PAPERLESS_SECRET_KEY` (and adjust timezone/OCR language as needed).
- Start (PowerShell): `./start-paperless.ps1`
- Start (Bash): `./start-paperless.sh`
- Stop (PowerShell): `./stop-paperless.ps1`
- Stop (Bash): `./stop-paperless.sh`

Append `-DryRun` (PowerShell) or `--dry-run` (Bash) to see the Compose command without running it.

After starting:
- Paperless-ngx UI: http://localhost:8000
- Paperless AI (chat assistant): http://localhost:3000

## Agent cue

When the user asks to start Paperless-ngx or to manage/ingest documents with Paperless, run the start script from this folder. Mention both service URLs after the stack is up. Ensure `paperless.env` exists before starting.

## References

- [Paperless-ngx Documentation](https://docs.paperless-ngx.com/)
- [Paperless-ngx GitHub Repository](https://github.com/paperless-ngx/paperless-ngx)
- [Docker Hub - Paperless-ngx](https://hub.docker.com/r/paperlessngx/paperless-ngx)
- [Paperless AI GitHub Repository](https://github.com/clusterzx/paperless-ai)
