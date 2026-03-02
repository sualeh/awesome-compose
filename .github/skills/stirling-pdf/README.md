# Stirling PDF Skill

Skill location: .github/skills/stirling-pdf.

This skill starts and stops the Stirling PDF container locally with Docker Compose so an AI agent can bring up Stirling PDF when asked to "start Stirling PDF" or to work with PDF files.

## Files

- compose.yaml: Compose definition exposing Stirling PDF on http://localhost:8080 and wiring data/config volumes
- start-stirling-pdf.sh / start-stirling-pdf.ps1: Start Stirling PDF with `docker compose up -d`
- stop-stirling-pdf.sh / stop-stirling-pdf.ps1: Stop and remove Stirling PDF with `docker compose down`

## Usage (agent or human)

- Start (PowerShell): `./start-stirling-pdf.ps1`
- Start (Bash): `./start-stirling-pdf.sh`
- Stop (PowerShell): `./stop-stirling-pdf.ps1`
- Stop (Bash): `./stop-stirling-pdf.sh`

Append `-DryRun` (PowerShell) or `--dry-run` (Bash) to see the Compose command without running it.

After starting, Stirling PDF is available at http://localhost:8080.

## Agent cue

When the user asks to start Stirling PDF or to work with PDF files, run the start script from this folder. Offer the access URL after the container is up.

## References

- [Stirling PDF GitHub Repository](https://github.com/Stirling-Tools/Stirling-PDF)
- [Docker Hub - Stirling PDF](https://hub.docker.com/r/frooodle/s-pdf)
- [Stirling PDF Documentation](https://github.com/Stirling-Tools/Stirling-PDF/blob/main/README.md)

