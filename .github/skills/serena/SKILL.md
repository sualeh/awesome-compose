---
name: serena
description: Starts and stops a local Serena MCP server with Docker Compose. Use this skill when the user asks to start Serena, start an MCP server, or run Serena over streamable HTTP. Exposes the Serena MCP endpoint on http://localhost:9121.
license: Apache-2.0
metadata:
  author: sualeh
  version: "1.0"
compatibility: Requires Docker and Docker Compose installed on the host.
---
# Serena Skill

Skill location: `.github/skills/serena`

This skill starts and stops the Serena MCP server locally with Docker Compose so an AI agent can bring up Serena when asked to "start Serena", "start an MCP server", or to use Serena tooling over HTTP.

## Files

- `compose.yaml`: Compose definition exposing Serena MCP on http://localhost:9121
- `serena.env.example`: Example env file; copy to `serena.env` and set host workspace paths for bind mounts
- `serena-config.yml`: Serena Docker configuration mounted into the container
- `start-serena.sh` / `start-serena.ps1`: Start Serena with `docker compose up -d`
- `stop-serena.sh` / `stop-serena.ps1`: Stop and remove Serena with `docker compose down`

## Usage (agent or human)

1) Copy `serena.env.example` to `serena.env` and set `WORKSPACE_1` and `WORKSPACE_2` to valid local paths.
2) Start (PowerShell): `./start-serena.ps1`
3) Start (Bash): `./start-serena.sh`
4) Stop (PowerShell): `./stop-serena.ps1`
5) Stop (Bash): `./stop-serena.sh`

Append `-DryRun` (PowerShell) or `--dry-run` (Bash) to see the Compose command without running it.

After starting, Serena MCP is available at http://localhost:9121.

## Agent Instructions

When the user asks to start Serena or to run a local Serena MCP server, ensure `serena.env` exists and points to real host workspace paths. Run the start script from this folder, then share the MCP endpoint URL. Use the stop script to tear down the container when done.

## References

- [Serena GitHub Repository](https://github.com/oraios/serena)
- [Serena Container Registry](https://github.com/oraios/serena/pkgs/container/serena)
- [Model Context Protocol](https://modelcontextprotocol.io/)
