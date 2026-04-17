# Serena Skill

Skill location: .github/skills/serena.

This skill starts and stops the Serena MCP server locally with Docker Compose so an AI agent can bring up Serena when asked to "start Serena", "start an MCP server", or to use Serena tooling over HTTP.

## Files

- compose.yaml: Compose definition exposing Serena MCP endpoint on http://localhost:9121
- .env.example: Example environment file; copy to `.env` and set valid host workspace paths
- serena-config.yml: Serena Docker configuration mounted into the container
- start-serena.sh / start-serena.ps1: Start Serena with `docker compose up -d`
- stop-serena.sh / stop-serena.ps1: Stop and remove Serena with `docker compose down`

## Usage (agent or human)

1. Copy .env.example to .env and set WORKSPACE_1 and WORKSPACE_2 to valid local paths.
2. Start (PowerShell): `./start-serena.ps1`
3. Start (Bash): `./start-serena.sh`
4. Stop (PowerShell): `./stop-serena.ps1`
5. Stop (Bash): `./stop-serena.sh`

Append `-DryRun` (PowerShell) or `--dry-run` (Bash) to see the Compose command without running it.

After starting, Serena MCP is available at http://localhost:9121.

## Agent cue

When the user asks to start Serena or to run a local Serena MCP server, ensure `.env` exists and points to valid paths. The start scripts rely on Docker Compose's default `.env` loading. Run the start script from this folder and share the endpoint URL.

## References

- [Serena GitHub Repository](https://github.com/oraios/serena)
- [Serena Container Registry](https://github.com/oraios/serena/pkgs/container/serena)
- [Model Context Protocol](https://modelcontextprotocol.io/)
