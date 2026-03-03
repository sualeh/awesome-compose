# Pandoc Skill

Skill location: .github/skills/pandoc.

This skill starts and stops a long-running Pandoc container with Docker Compose and then uses a Bash shell inside that container to run one or more document conversions on demand. Converted files are written into the `output/` folder at the root of this repository.

## Files

- compose.yaml: Compose definition for the `pandoc/extra` image with host volumes mounted
- start-pandoc.sh / start-pandoc.ps1: Start the Pandoc container with `docker compose up -d`
- stop-pandoc.sh / stop-pandoc.ps1: Stop and remove the Pandoc container with `docker compose down`
- convert-pandoc.sh / convert-pandoc.ps1: Run a single Pandoc conversion in the running container

## Usage (agent or human)

1. Start the container
   - PowerShell: `./start-pandoc.ps1`
   - Bash: `./start-pandoc.sh`

2. Convert a file
   - Bash: `./convert-pandoc.sh /absolute/path/to/file.md pdf`
   - PowerShell: `./convert-pandoc.ps1 -InputPath ./README.md -OutputFormat pdf`

   The converted file will be written as `output/<basename>.<format>` at the repo root (for example, `output/README.pdf`).

   - On Linux, absolute paths anywhere on the host are supported via the `/` → `/host` bind mount.
   - On Windows, the PowerShell helper currently supports files that live under this repository root (paths inside the repo).

3. Stop the container when finished
   - PowerShell: `./stop-pandoc.ps1`
   - Bash: `./stop-pandoc.sh`

Append `-DryRun` (PowerShell) or `--dry-run` (Bash) to see the underlying `docker compose` command without executing it.

## Agent cue

When the user asks to convert a local document with Pandoc (for example, "convert this Markdown file to PDF"), ensure the Pandoc container is running (start script), then call the appropriate convert script with the full input path and desired output format. After conversions are complete, the agent can call the stop script to tear down the container.

## Notes

- Output files are always written to the `output/` directory at the root of this project.
- The Bash helper attempts to handle both files inside the repository and arbitrary absolute paths on Linux hosts.
- The PowerShell helper restricts input paths to locations under the repository root to match Docker Desktop volume semantics on Windows.
