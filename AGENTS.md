# OpenCode Custom Agents

This directory contains definitions for the custom subagents configured in your OpenCode DX environment.

---

## Agent Registry

### 🏗️ StackScaffolder
*   **File:** `agents/StackScaffolder.md`
*   **Description:** Scaffolds React (Vite), React Native (Expo SDK 52+), Python (FastAPI/scripts), and Pixi cross-language projects with Supabase, Tailwind/NativeWind, and Turborepo support.
*   **Model:** `google/gemini-flash-lite-latest`
*   **Features:**
    *   **Web:** Vite + React + TS + Tailwind + Supabase
    *   **Mobile:** Expo SDK 52+ + TS + NativeWind + Supabase
    *   **Python:** FastAPI modular structure or data scripts with `uv` + `ruff` + `pytest`
    *   **Pixi:** Cross-language Python + Node.js monorepo with `src/` and `web/` structure
    *   Enforces minimal directory structure (`components/`, `hooks/`, `lib/`, `types/`)
    *   Asks for project name and author upfront; everything else is autonomous

### 🛠️ CodeSentinel
*   **File:** `agents/CodeSentinel.md`
*   **Description:** Automated quality and security sentinel for pre-check/pre-push. Auto-fixes lint/format, reports errors, runs tests on-demand.
*   **Model:** `google/gemini-flash-lite-latest`
*   **Features:**
    *   **Pre-Push Mode:** Runs linters + formatters + security scan only (skips tests)
    *   **On-Demand Mode:** Full suite including test execution
    *   Auto-detects project type (JS/TS, Python, Pixi)
    *   Auto-fixes everything possible with detailed change logs
    *   Secret scanning via grep for common patterns (API keys, tokens, etc.)
    *   Smart test discovery — warns and skips if no framework detected
    *   Outputs pass/fail verdict for git hook integration

### 🗄️ DataBridge
*   **File:** `agents/DataBridge.md`
*   **Description:** Supabase and PostgreSQL database management — type generation, migrations, client queries, and schema reporting.
*   **Model:** `google/gemini-flash-lite-latest`
*   **Features:**
    *   **Type Generation:** On-demand TypeScript types via `supabase gen types`
    *   **Post-Migration Sync:** Automatically regenerates types after migrations
    *   **Migration Assistant:** Drafts SQL with RLS policies, indexes, and triggers from natural language descriptions
    *   **Client Query Generation:** Generates `@supabase/supabase-js` and `supabase-py` queries
    *   **Project Reporting:** Inspects schema, RLS policies, indexes, and flags tables without RLS

### ✍️ ContentArchitect
*   **File:** `agents/ContentArchitect.md`
*   **Description:** Content creation agent with research and quick-read modes. Supports web search (Tavily/Jina.ai) for in-depth research.
*   **Model:** `google/gemini-flash-lite-latest`
*   **Permissions:** `websearch: allow`
*   **Features:**
    *   **Research Mode:** Deep-dive articles with extensive web research, saved to Obsidian vault
    *   **Blog Post Mode:** Long-form polished content with code examples
    *   **Quick Read Mode:** 7 selectable writing styles (Professional, Casual, Storytelling, Opinion, Tutorial, TL;DR, Thought Leadership)
    *   Includes structured templates for research and blog content
    *   Confirms vault path on every session

### 🌉 ContentBridge
*   **File:** `agents/ContentBridge.md`
*   **Description:** Content transformation agent — summarizes long-form articles into platform-optimized social media posts.
*   **Model:** `google/gemini-flash-lite-latest`
*   **Features:**
    *   **Target Platforms:** X (threads), LinkedIn, Dev.to, Personal Blog
    *   **7 Writing Styles:** Same palette as ContentArchitect Quick Read
    *   **Platform-Specific Formatting:** Character limits, hashtags, frontmatter, tone guidelines
    *   Saves outputs to `Social/` folder in Obsidian vault

---

## How to Add a New Agent
1. Create a markdown file inside the `agents/` folder (e.g., `agents/MyNewAgent.md`).
2. Add the metadata frontmatter at the top:
   ```markdown
   ---
   description: Briefly describe what the agent does.
   mode: subagent
   model: google/gemini-flash-lite-latest
   ---
   ```
3. Provide the system instructions in the body of the markdown file.
4. Run `setup.sh` to update symlinks.
5. **Restart opencode** for the new agent to be loaded and available via the `@` menu.
