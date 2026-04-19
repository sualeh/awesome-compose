# Serena Skill

Skill location: .github/skills/serena.

This skill starts and stops the Serena MCP server locally with Docker Compose so an AI agent can bring up Serena when asked to "start Serena", "start an MCP server", or to use Serena tooling over HTTP.

## Files

- compose.yaml: Compose definition exposing Serena MCP endpoint on http://localhost:9121
- .env.example: Example environment file to initialize .env with SERENA_PROJECT_PATH
- serena-config.yml: Serena Docker configuration mounted into the container
- start-serena.sh / start-serena.ps1: Read SERENA_PROJECT_PATH from .env and start Serena with `docker compose up -d`
- stop-serena.sh / stop-serena.ps1: Stop and remove Serena with `docker compose down`

## Usage (agent or human)

1. Copy .env.example to .env and set SERENA_PROJECT_PATH to the local project path Serena should activate.
2. Start (PowerShell): `./start-serena.ps1`
3. Start (Bash): `./start-serena.sh`
4. Stop (PowerShell): `./stop-serena.ps1`
5. Stop (Bash): `./stop-serena.sh`

Append `-DryRun` (PowerShell) or `--dry-run` (Bash) to see the Compose command without running it.

After starting, Serena MCP is available at http://localhost:9121.
The selected project path is mounted at /workspaces/active-project and activated automatically with `serena start-mcp-server --project /workspaces/active-project`.

## Agent cue

When the user asks to start Serena or to run a local Serena MCP server, ensure .env exists with SERENA_PROJECT_PATH set to the desired project path. Do not prompt at runtime; the start scripts read from .env and Serena auto-activates that project on startup. Run the start script from this folder and share the endpoint URL.

## References

- [Serena GitHub Repository](https://github.com/oraios/serena)
- [Serena Container Registry](https://github.com/oraios/serena/pkgs/container/serena)
- [Model Context Protocol](https://modelcontextprotocol.io/)
