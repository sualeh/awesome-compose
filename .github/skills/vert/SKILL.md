---
name: vert
description: Starts and stops a local VERT file-converter container with Docker Compose. Use this skill when the user asks to start VERT or to convert files with VERT. VERT supports 250+ file formats including images, audio, documents, and video, and exposes a web UI on http://localhost:8080.
license: Apache-2.0
metadata:
  author: sualeh
  version: "1.0"
compatibility: Requires Docker and Docker Compose installed on the host.
---
# Vert Skill

Skill location: `.github/skills/vert`

This skill starts and stops the Vert container locally with Docker Compose so an AI agent can bring up Vert when asked to "start Vert" or to convert files.

## Files

- `compose.yaml`: Compose definition exposing Vert on http://localhost:8080
- `start-vert.sh` / `start-vert.ps1`: Start Vert with `docker compose up -d`
- `stop-vert.sh` / `stop-vert.ps1`: Stop and remove Vert with `docker compose down`

## Usage (agent or human)

- Start (PowerShell): `./start-vert.ps1`
- Start (Bash): `./start-vert.sh`
- Stop (PowerShell): `./stop-vert.ps1`
- Stop (Bash): `./stop-vert.sh`

Append `-DryRun` (PowerShell) or `--dry-run` (Bash) to see the Compose command without running it.

After starting, Vert is available at http://localhost:8080.

## Agent Instructions

When the user asks to start Vert or to convert files with Vert, run the start script from this folder. Offer the access URL after the container is up.

## References

- [VERT GitHub Repository](https://github.com/VERT-sh/VERT)
- [VERT Official Website](https://vert.sh/)
- [Docker Hub - VERT](https://github.com/orgs/VERT-sh/packages/container/package/vert)
