# AnythingLLM Skill

Skill location: `.github/skills/anythingllm`

This skill starts and stops the AnythingLLM + Ollama stack locally with Docker Compose so an AI agent can bring up a private, on-device RAG server when asked to "start AnythingLLM" or to "chat with my PDFs". The stack runs entirely on-device and answers questions with citations grounded only in indexed documents.

## Files

- `compose.yaml`: Compose definition for the Ollama LLM service, a one-shot model puller, and AnythingLLM, with named volumes for persistence
- `start-anythingllm.sh` / `start-anythingllm.ps1`: Pull latest images, generate `.env` if missing, and start the stack with `docker compose up -d`
- `stop-anythingllm.sh` / `stop-anythingllm.ps1`: Stop the stack with `docker compose stop` (preserves data)
- `ABOUT.md`: Background on AnythingLLM and Ollama
- `.gitignore`: Excludes the generated `.env` file from version control

## Usage (agent or human)

- Start (PowerShell): `./start-anythingllm.ps1`
- Start (Bash): `./start-anythingllm.sh`
- Stop (PowerShell): `./stop-anythingllm.ps1`
- Stop (Bash): `./stop-anythingllm.sh`

Append `-DryRun` (PowerShell) or `--dry-run` (Bash) to see the Compose commands without running them.

The start script always runs `docker compose pull` before `docker compose up -d` so image updates are applied on each start.

After starting:

- AnythingLLM UI: <http://localhost:3001>
- Ollama API: <http://localhost:11434>

First boot pulls the default models (`llama3.2:3b` and `nomic-embed-text`) into the `ollama_data` volume. This is a one-time cost; subsequent starts skip the download.

## Agent Instructions

When the user asks to start AnythingLLM, run a local RAG server, or chat with their PDFs, run the start script from this folder. Tell the user that the UI will be available at <http://localhost:3001> after the container is healthy, and that first boot may take a couple of minutes while Ollama warms up and models download.

When the user asks to stop AnythingLLM, run the stop script. Data (embeddings, models, settings) is preserved in named Docker volumes and is available again on next start.

To wipe all data, the user must run `docker compose down -v` from this folder manually.

## Customization

Default models can be changed in `compose.yaml`:

- `OLLAMA_MODEL_PREF` — chat model (default `llama3.2:3b`)
- `EMBEDDING_MODEL_PREF` — embedding model (default `nomic-embed-text:latest`)

After changing, restart the stack so the new models pull on the next `up`.

## References

- [AnythingLLM GitHub repository](https://github.com/Mintplex-Labs/anything-llm)
- [AnythingLLM documentation](https://docs.anythingllm.com)
- [Docker Hub — mintplexlabs/anythingllm](https://hub.docker.com/r/mintplexlabs/anythingllm)
- [Ollama GitHub repository](https://github.com/ollama/ollama)
- [Docker Hub — ollama/ollama](https://hub.docker.com/r/ollama/ollama)
