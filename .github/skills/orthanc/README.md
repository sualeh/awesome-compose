# Orthanc Skill

Skill location: .github/skills/orthanc.

This skill starts and stops the Orthanc DICOM server locally with Docker Compose so an AI agent can bring up Orthanc when asked to "start Orthanc", "start a DICOM server", or to work with DICOM files.

## Files

- compose.yaml: Compose definition exposing Orthanc UI on http://localhost:8042 and DICOM on 4242
- start-orthanc.sh / start-orthanc.ps1: Start Orthanc with `docker compose up -d`
- stop-orthanc.sh / stop-orthanc.ps1: Stop and remove Orthanc with `docker compose down`

## Usage (agent or human)

- Start (PowerShell): `./start-orthanc.ps1`
- Start (Bash): `./start-orthanc.sh`
- Stop (PowerShell): `./stop-orthanc.ps1`
- Stop (Bash): `./stop-orthanc.sh`

Append `-DryRun` (PowerShell) or `--dry-run` (Bash) to see the Compose command without running it.

After starting, Orthanc UI is available at http://localhost:8042 (default login: orthanc / orthanc). DICOM C-STORE is available on port 4242.

## Agent cue

When the user asks to start Orthanc, start a DICOM server, or to work with DICOM files, run the start script from this folder. Offer the access URL and default credentials after the container is up.

## References

- [Orthanc Official Website](https://www.orthanc-server.com/)
- [Orthanc Viewer GitHub Repository](https://github.com/npettiaux/orthanc-viewer)
- [Orthanc Docker Hub](https://hub.docker.com/r/jodogne/orthanc-plugins)
- [Orthanc Documentation](https://book.orthanc-server.com/)
