#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define directories
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_CONFIG_DIR="$HOME/.config/opencode"
KEYS_DIR="$HOME/.keys"
BASHRC="$HOME/.bashrc"

echo "=== OpenCode DX Setup Script ==="

# 1. Create ~/.keys if it doesn't exist
if [ ! -d "$KEYS_DIR" ]; then
    echo "Creating keys directory at $KEYS_DIR..."
    mkdir -p "$KEYS_DIR"
    # Create empty placeholders for tavily and jina
    touch "$KEYS_DIR/tavily"
    touch "$KEYS_DIR/jina"
    echo "Created empty key files. Please add your actual keys to:"
    echo "  - $KEYS_DIR/tavily"
    echo "  - $KEYS_DIR/jina"
else
    echo "Keys directory already exists at $KEYS_DIR."
fi

# 2. Add API key loader snippet to .bashrc if not already present
LOADER_COMMENT="# --- OpenCode Key Loader ---"
if ! grep -qF "$LOADER_COMMENT" "$BASHRC" 2>/dev/null; then
    echo "Appending OpenCode Key Loader snippet to $BASHRC..."
    cat << 'EOF' >> "$BASHRC"

# --- OpenCode Key Loader ---
if [ -d "$HOME/.keys" ]; then
    export TAVILY_API_KEY=$(cat "$HOME/.keys/tavily" 2>/dev/null)
    export JINA_API_KEY=$(cat "$HOME/.keys/jina" 2>/dev/null)
fi
EOF
    echo "Key loader added to $BASHRC. (Note: Run 'source ~/.bashrc' or restart your terminal to apply)."
else
    echo "Key loader snippet already present in $BASHRC."
fi

# 3. Ensure ~/.config/opencode exists
mkdir -p "$TARGET_CONFIG_DIR"

# 4. Create symlinks for configuration files/folders
items=("opencode.jsonc" "package.json" "package-lock.json" "agents")

for item in "${items[@]}"; do
    source_path="$REPO_DIR/$item"
    target_path="$TARGET_CONFIG_DIR/$item"

    if [ -e "$source_path" ]; then
        # Check if target already exists
        if [ -e "$target_path" ] || [ -L "$target_path" ]; then
            # If it's a symlink, remove it to update it
            if [ -L "$target_path" ]; then
                rm "$target_path"
            else
                # Back up existing files/folders
                echo "Backing up existing $target_path to $target_path.bak..."
                mv "$target_path" "$target_path.bak"
            fi
        fi
        
        # Create symlink
        echo "Linking $target_path -> $source_path..."
        ln -s "$source_path" "$target_path"
    fi
done

# 5. Run npm install inside target configuration directory to restore plugins
if [ -f "$TARGET_CONFIG_DIR/package.json" ]; then
    echo "Installing/updating plugins in $TARGET_CONFIG_DIR..."
    cd "$TARGET_CONFIG_DIR"
    npm install
fi

echo "=== Setup Completed Successfully! ==="
