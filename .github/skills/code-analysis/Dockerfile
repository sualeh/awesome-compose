FROM python:3.12.8-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PROJECT_PATH=/project

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl git build-essential npm \
    && npm install -g @ast-grep/cli \
    && ln -sf /usr/local/bin/sg /usr/local/bin/ast-grep \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /project
WORKDIR /app

RUN pip install --no-cache-dir git+https://github.com/intelops/code-analysis-mcp-server.git

EXPOSE 8000
VOLUME ["/project"]
ENTRYPOINT ["code-analysis-server"]
