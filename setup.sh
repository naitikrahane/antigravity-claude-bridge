#!/usr/bin/env bash
set -e

echo "===================================================================="
echo "     ANTIGRAVITY CLAUDE BRIDGE - AUTOMATED 1-CLICK INSTALLER        "
echo "===================================================================="
echo ""

# 1. Check Node.js
if ! command -v node >/dev/null 2>&1; then
    echo "[ERROR] Node.js is not installed."
    echo "Please install Node.js (v20+) from https://nodejs.org/"
    exit 1
fi
echo "[1/5] Node.js detected."

# 2. Install Claude Code & Antigravity Proxy
echo "[2/5] Installing Claude Code and Antigravity Proxy globally..."
npm install -g @anthropic-ai/claude-code antigravity-claude-proxy

# 3. Configure settings.json with gateway model discovery
echo "[3/5] Configuring Claude Code settings with Model Gateway Discovery..."
mkdir -p "$HOME/.claude"
cat << 'EOF' > "$HOME/.claude/settings.json"
{
  "autoUpdates": false,
  "env": {
    "ANTHROPIC_BASE_URL": "http://localhost:8080",
    "ANTHROPIC_AUTH_TOKEN": "test",
    "CLAUDE_CODE_ENABLE_GATEWAY_MODEL_DISCOVERY": "1",
    "DISABLE_AUTOUPDATER": "1",
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "claude-sonnet-4-6",
    "ANTHROPIC_DEFAULT_OPUS_MODEL": "claude-opus-4-6-thinking",
    "ANTHROPIC_DEFAULT_HAIKU_MODEL": "gemini-3.8-flash-medium",
    "CLAUDE_CODE_SUBAGENT_MODEL": "gemini-3.5-flash-lite"
  }
}
EOF

# 4. Install Global Helper Launchers (claude-agy & claude-gemini)
echo "[4/5] Setting up global CLI commands (claude-agy and claude-gemini)..."
NPM_BIN_DIR="$(npm bin -g 2>/dev/null || dirname "$(npm root -g)")"
if [ -d "$NPM_BIN_DIR" ]; then
    cp -f "$(dirname "$0")/bin/claude-agy" "$NPM_BIN_DIR/claude-agy" 2>/dev/null || true
    chmod +x "$NPM_BIN_DIR/claude-agy" 2>/dev/null || true
    cp -f "$(dirname "$0")/bin/claude-gemini" "$NPM_BIN_DIR/claude-gemini" 2>/dev/null || true
    chmod +x "$NPM_BIN_DIR/claude-gemini" 2>/dev/null || true
fi

# 5. Check account
echo "[5/5] Checking Google account connection..."
if ! acc accounts list 2>/dev/null | grep -q "@"; then
    echo "Action Required: Link your Google Account"
    acc accounts add
fi

# Start proxy with hybrid load balancing across accounts
echo "Starting Antigravity Proxy with multi-account failover..."
acc start --strategy=hybrid --fallback

echo ""
echo "===================================================================="
echo "                   SETUP COMPLETED SUCCESSFULLY!                    "
echo "===================================================================="
echo ""
echo "You can now run Claude Code directly with:"
echo "  claude-agy     -> Claude Sonnet 4.6 (Antigravity)"
echo "  claude-gemini  -> Gemini 3.8 Flash (Antigravity)"
echo "  claude         -> Claude Code CLI with full model discovery"
echo ""
echo "To add more Google accounts for rotation:"
echo "  acc accounts add"
echo ""
