# opencode-dx

A collection of agents, templates, and workflows for agentic assistance in development work.

This repository allows you to version-control and easily sync your custom OpenCode configurations, custom agents, and templates across multiple WSL (Windows Subsystem for Linux) and Linux devices without exposing your private API keys.

---

## 🚀 Quick Start (For New Devices)

If you are setting up OpenCode on a new WSL environment:

1.  **Clone this repository** into your `~/repos` directory:
    ```bash
    mkdir -p ~/repos
    git clone https://github.com/Jzbonner/opencode-dx.git ~/repos/opencode-dx
    ```

2.  **Run the setup script**:
    ```bash
    cd ~/repos/opencode-dx
    chmod +x setup.sh
    ./setup.sh
    ```

3.  **Apply environment changes**:
    ```bash
    source ~/.bashrc
    ```

4.  **Add your actual API keys**:
    Add your raw keys inside your local `~/.keys` directory (e.g., paste your Tavily API key inside `~/.keys/tavily`).

---

## ⚙️ What the Setup Script (`setup.sh`) Does

The `setup.sh` script automates the complete configuration lifecycle. Here is exactly what happens when you run it:

1.  **Ensures API Keys Directory Exists**:
    *   Checks for a local directory at `~/.keys/`.
    *   If missing, it creates the folder and populates empty template files (`tavily`, `jina`) so you know exactly where to paste your keys.
2.  **Integrates dynamic Key Loader into `.bashrc`**:
    *   Safely appends a secure key-loader snippet to the end of your `~/.bashrc`.
    *   This dynamically loads keys into your active shell env *on-startup* without hardcoding secrets in your dotfiles or repository.
3.  **Backs up existing native configurations**:
    *   Before linking, the script checks if you have any existing pre-installed configuration files inside `~/.config/opencode/`.
    *   If found, it backs them up safely to `.bak` files (e.g., `opencode.jsonc.bak` and `agents.bak/`) to prevent data loss.
4.  **Configures Symlinks**:
    *   Creates active symbolic links pointing your system's OpenCode app paths to your version-controlled `opencode-dx` folders.
    *   Any edits made to `/agents` or `opencode.jsonc` in this repository are immediately active inside OpenCode!
5.  **Restores Plugins & Node Modules**:
    *   Triggers an automatic `npm install` inside your linked `~/.config/opencode/` directory to fetch and sync any plugins or dependencies (such as `@opencode-ai/plugin`).

---

## 🤖 Custom Agents
All custom agents are located inside the `agents/` directory. For a complete breakdown of current subagents (like `CodeSentinel` and `ContentArchitect`) and guidelines on how to build your own, check out [AGENTS.md](./AGENTS.md).

---

## 🔄 Keeping Configs in Sync

When making changes (e.g., adding a template or custom agent):

**On your active device:**
```bash
git add .
git commit -m "feat: added new custom agent"
git push
```

**On other devices:**
```bash
cd ~/repos/opencode-dx
git pull
# If new plugins/packages were added:
./setup.sh
```
