# OpenCode Custom Agents

This directory contains definitions for the custom subagents configured in your OpenCode DX environment.

---

## Agent Registry

### 🛠️ CodeSentinel
*   **File:** `agents/CodeSentinel.md`
*   **Description:** Automated quality and security sentinel for pre-check/pre-push.
*   **Model:** `google/gemini-flash-lite-latest`
*   **Features:**
    *   Detects project type (JS/TS, Python)
    *   Runs code formatting (e.g., Prettier) and linting (e.g., ESLint, Ruff)
    *   Runs lightweight test suites
    *   Scans for secrets and security issues

### ✍️ ContentArchitect
*   **File:** `agents/ContentArchitect.md`
*   **Description:** Content creation agent with research and quick-read modes, supporting web search.
*   **Model:** `google/gemini-flash-lite-latest`
*   **Features:**
    *   **Research Mode:** Utilizes web search (Tavily/Jina.ai) and local notes to write structured markdown articles.
    *   **Quick Read Mode:** Synthesizes local notes into concise, impactful markdown posts.
    *   Formats outputs directly for Obsidian vaults.

### 🌉 ContentBridge
*   **File:** `agents/ContentBridge.md`
*   **Description:** Content transformation agent for summarization and social media tailoring.
*   **Model:** `google/gemini-flash-lite-latest`

### 🗄️ DataBridge
*   **File:** `agents/DataBridge.md`
*   **Description:** Supabase and database management assistant.
*   **Model:** `google/gemini-flash-lite-latest`

### 🏗️ StackScaffolder
*   **File:** `agents/StackScaffolder.md`
*   **Description:** Scaffolds React/ReactNative/TypeScript/Node/Python projects with standard architecture.
*   **Model:** `google/gemini-flash-lite-latest`

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
4. Run `setup.sh` to update symlinks or register the new agent to your OpenCode environment.
