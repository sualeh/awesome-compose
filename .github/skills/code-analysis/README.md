# Code Analysis Skill

Skill location: .github/skills/code-analysis.

This skill starts and stops the intelops/code-analysis-mcp-server locally with Docker Compose so an AI agent can run code-analysis MCP workflows against a selected project path.

## Files

- compose.yml: Compose definition exposing code-analysis MCP endpoint on http://localhost:8000
- .env.example: Example environment file to initialize .env with LOCAL_PROJECT_PATH
- start-code-analysis.sh / start-code-analysis.ps1: Read LOCAL_PROJECT_PATH from .env and start the service with `docker compose up -d`
- stop-code-analysis.sh / stop-code-analysis.ps1: Stop and remove the service with `docker compose down`

## Usage (agent or human)

1. Copy .env.example to .env and set LOCAL_PROJECT_PATH to the local project path you want analyzed.
2. Start (PowerShell): `./start-code-analysis.ps1`
3. Start (Bash): `./start-code-analysis.sh`
4. Stop (PowerShell): `./stop-code-analysis.ps1`
5. Stop (Bash): `./stop-code-analysis.sh`

Append `-DryRun` (PowerShell) or `--dry-run` (Bash) to see the Compose command without running it.

After starting, code-analysis MCP is available at http://localhost:8000.
The selected project path is mounted into the container at /project and exposed to the server through PROJECT_PATH=/project.

## Agent cue

When the user asks to start code analysis MCP or intelops/code-analysis-mcp-server, ensure .env exists with LOCAL_PROJECT_PATH set to the desired local project path. Do not prompt at runtime; the start scripts read from .env. Run the start script from this folder, then share the endpoint URL. Use the stop script to tear down the container when done.

## References

- [intelops/code-analysis-mcp-server](https://hub.docker.com/r/intelops/code-analysis-mcp-server)
- [Model Context Protocol](https://modelcontextprotocol.io/)
