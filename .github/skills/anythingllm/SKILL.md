---
name: anythingllm
description: Starts and stops a local AnythingLLM stack (Ollama and AnythingLLM) with Docker Compose. Use this skill when the user asks to start AnythingLLM, run a local RAG server, chat with their PDFs privately, or stand up a local LLM. The stack runs entirely on-device, indexes PDFs in a local vector store, and answers questions with citations grounded only in the indexed documents. Exposes the AnythingLLM UI on http://localhost:3001 and the Ollama API on http://localhost:11434.
---

# AnythingLLM Skill

Skill location: `.github/skills/anythingllm`

This skill starts and stops a local AnythingLLM + Ollama stack with Docker Compose so an AI agent can bring up a private, on-device RAG server when asked to "start AnythingLLM" or to "chat with my PDFs". Answers are grounded only in indexed documents (no internet calls during inference) and include citations back to source PDFs.

## Usage

- Start (PowerShell): `./start-anythingllm.ps1`
- Start (Bash): `./start-anythingllm.sh`
- Stop (PowerShell): `./stop-anythingllm.ps1`
- Stop (Bash): `./stop-anythingllm.sh`

Start always pulls the latest Docker images before bringing the stack up, so security and bug fixes from Ollama and AnythingLLM are applied on each start.

Append `-DryRun` (PowerShell) or `--dry-run` (Bash) to see the Compose commands without running them.

After starting:

- AnythingLLM UI: <http://localhost:3001>
- Ollama API: <http://localhost:11434>

First boot warms up Ollama and pulls the default models (`llama3.2:3b` and `nomic-embed-text`), which can take several minutes on first run depending on connection speed.

## Agent instructions

When the user asks to start AnythingLLM, run a local RAG server, or chat with their PDFs, run the start script from this folder. Tell the user the UI will be at <http://localhost:3001> after the container is healthy, and that first boot may take a couple of minutes while Ollama warms up.

When the user asks to stop AnythingLLM, run the stop script. Note that this preserves data (embeddings, models, settings) — they survive in named Docker volumes and are available again on next start.

The start script generates a `JWT_SECRET` and writes it to `.env` on first run if one doesn't already exist. Don't commit `.env` — it's already in this folder's `.gitignore`.

To wipe data (embeddings + downloaded models) the user must run `docker compose down -v` from this folder manually. The stop script never deletes data.
