# Pandoc Skill

Skill location: .github/skills/pandoc.

This skill uses Docker Compose to spin up a short-lived Pandoc container for each conversion request. Each invocation of the convert script starts a container, runs a single document conversion, and then removes the container. Converted files are written into the `output/` folder at the root of this repository.

## Files

- compose.yaml: Compose definition for the `pandoc/extra` image with host volumes mounted
- convert-pandoc.sh / convert-pandoc.ps1: Run a single Pandoc conversion using `docker compose run --rm` (one container per request)

## Usage (agent or human)

1. Convert a file
   - Bash: `./convert-pandoc.sh /absolute/path/to/file.md pdf`
   - PowerShell: `./convert-pandoc.ps1 -InputPath ./README.md -OutputFormat pdf`

   The converted file will be written as `output/<basename>.<format>` at the repo root (for example, `output/README.pdf`).

   - On Linux, absolute paths anywhere on the host are supported via the `/` → `/host` bind mount.
   - On Windows, the PowerShell helper currently supports files that live under this repository root (paths inside the repo).

Append `-DryRun` (PowerShell) or `--dry-run` (Bash) to see the underlying `docker compose` command without executing it.

## Agent cue

When the user asks to convert a local document with Pandoc (for example, "convert this Markdown file to PDF"), call the appropriate convert script with the full input path and desired output format. The script will start a short-lived container for that conversion and remove it when finished; there is no need to keep a long-running container running between requests.

## Notes

- Output files are always written to the `output/` directory at the root of this project.
- The Bash helper attempts to handle both files inside the repository and arbitrary absolute paths on Linux hosts.
- The PowerShell helper restricts input paths to locations under the repository root to match Docker Desktop volume semantics on Windows.
