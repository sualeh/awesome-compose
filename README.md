# Sualeh's Awesome Compose [![Awesome](https://awesome.re/badge.svg)](https://awesome.re)

> Yes, I stole the repo name from [docker/awesome-compose](https://github.com/docker/awesome-compose). I am not sorry. :smile:

## Getting started

### Prerequisites

- Make sure that you have Docker and Docker Compose installed
  - Windows or macOS:
    [Install Docker Desktop](https://www.docker.com/get-started)
  - Linux: [Install Docker](https://www.docker.com/get-started) and then
    [Docker Compose](https://github.com/docker/compose)
- Clone this repository.

### Running a Utility

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
