# Sualeh's Awesome Compose [![Awesome](https://awesome.re/badge.svg)](https://awesome.re)

> Yes, I stole the repo name from [docker/awesome-compose](https://github.com/docker/awesome-compose). I am not sorry. :smile:

## Prerequisites

- Make sure that you have Docker and Docker Compose installed
  - Windows or macOS:
    [Install Docker Desktop](https://www.docker.com/get-started)
  - Linux: [Install Docker](https://www.docker.com/get-started) and then
    [Docker Compose](https://github.com/docker/compose)
- Clone this repository.


## Running a Utility

The root directory of each utility contains the `compose.yaml` which
describes the configuration of service components. All utilities can be run in
a local environment by going into the root directory of any of them and executing:

```console
docker compose up -d
```

Check the `README.md` of each sample to get more details.

To stop and remove all containers of the sample application run:

```console
docker compose down
```

### Skills used by the AI agent

Agent-triggered utilities live under `.github/skills/` and provide start/stop helper scripts the agent can call:

- Stirling PDF: [.github/skills/stirling-pdf](.github/skills/stirling-pdf) — start with `./start-stirling-pdf.sh` or `./start-stirling-pdf.ps1`
- Vert: [.github/skills/vert](.github/skills/vert) — start with `./start-vert.sh` or `./start-vert.ps1`
- Orthanc: [.github/skills/orthanc](.github/skills/orthanc) — start with `./start-orthanc.sh` or `./start-orthanc.ps1`


## References

1. [Awesome Compose](https://github.com/docker/awesome-compose)
2. [Useful Docker Compose](https://github.com/RajawatBanna/useful-docker-compose)
