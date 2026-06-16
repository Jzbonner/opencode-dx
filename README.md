<p align="center">
  <img src="docs/logo.svg" width="120" alt="opencode-dx logo"/>
</p>

<h1 align="center">opencode-dx</h1>

<p align="center">
  A collection of agents, templates, and workflows for agentic assistance in development work
</p>

<p align="center">
  <a href="#quick-start">Quick Start</a> •
  <a href="AGENTS.md">Agents</a> •
  <a href="#keeping-configs-in-sync">Sync</a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/opencode-v0.5.0-6366f1?style=flat-square" alt="opencode">
  <img src="https://img.shields.io/badge/license-MIT-8b5cf6?style=flat-square" alt="license">
  <img src="https://img.shields.io/badge/PRs-welcome-22c55e?style=flat-square" alt="PRs welcome">
  <img src="https://img.shields.io/badge/platform-linux%20%7C%20wsl-64748b?style=flat-square" alt="platform">
</p>

Version-control and easily sync your custom OpenCode configurations, agents, and templates across multiple WSL and Linux devices — without exposing your private API keys.

---

## Quick Start

Clone and run on any new WSL environment:

```bash
git clone https://github.com/Jzbonner/opencode-dx.git ~/repos/opencode-dx
cd ~/repos/opencode-dx
./setup.sh
source ~/.bashrc
```

Then add your actual API keys to `~/.keys/tavily` and `~/.keys/jina`.**

After setup, **restart opencode** to load the new agent definitions.

---

## What the Setup Script Does

The `setup.sh` script automates the entire configuration lifecycle:

| Step | Action |
|------|--------|
| 1 | Creates `~/.keys/` with empty template files if missing |
| 2 | Appends a secure key-loader snippet to `~/.bashrc` |
| 3 | Backs up any existing `~/.config/opencode/` files to `.bak` |
| 4 | Creates symlinks from `~/.config/opencode/` → your repo files |
| 5 | Runs `npm install` to restore plugins and dependencies |

Any edits made to `agents/` or `opencode.jsonc` in this repo are immediately active in OpenCode.

---

## Agents

All custom agents live in [`agents/`](agents/). Current registry:

- **StackScaffolder** — scaffolds Web (Vite+React+TS), Mobile (Expo SDK 52+), Python (FastAPI/scripts), and Pixi (cross-language) projects with Supabase, Tailwind/NativeWind, and minimal directory structures
- **CodeSentinel** — automated quality gate: auto-fixes lint/format, runs security scans, executes tests on-demand, outputs pass/fail verdict for git hook integration
- **DataBridge** — Supabase and PostgreSQL management: TypeScript type generation, SQL migration drafting, client query generation, and schema/RLS reporting
- **ContentArchitect** — content creation with two modes: Research (deep-dive with web search via Tavily/Jina.ai, saved to Obsidian vault) and Quick Read (concise posts in 7 writing styles)
- **ContentBridge** — transforms long-form articles into platform-optimized posts for X, LinkedIn, Dev.to, and Personal Blog with 7 configurable writing styles

See [AGENTS.md](AGENTS.md) for details and instructions on adding new agents.

---

## Keeping Configs in Sync

**On your active device:**

```bash
git add .
git commit -m "feat: add new agent or template"
git push
```

**On other devices:**

```bash
cd ~/repos/opencode-dx
git pull
./setup.sh
```
