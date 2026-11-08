# 🛸 Antigravity Claude Code Bridge

> Run Anthropic's **Claude Code CLI** completely free, powered by **Google Antigravity & Gemini models** — **No Anthropic API key, no Gemini API key, and no paid subscriptions required!**

[![Node.js](https://img.shields.io/badge/Node.js-v20%2B-green.svg)](https://nodejs.org/)
[![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20macOS%20%7C%20Linux-blue.svg)]()
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Multi-Account](https://img.shields.io/badge/Feature-Multi--Account%20Rotation-purple.svg)]()

---

## 🌟 Why This Bridge?

Anthropic's **Claude Code** is an exceptional terminal-native autonomous coding agent, but it normally requires an expensive \$20/month subscription or paid Anthropic API credits.

This bridge connects Claude Code's terminal interface directly to your **Google Account (Antigravity ecosystem)** through a high-performance local proxy. It allows Claude Code to execute multi-file edits, terminal commands, deep reasoning, and autonomous tool loops using Google Antigravity backend models for free.

---

## ✨ Key Capabilities

- **Zero API Keys:** Authenticate using official Google OAuth via your browser — no credit cards, no billing setup.
- **Multi-Account Quota Rotation:** Add multiple Google accounts (`acc accounts add`). The proxy automatically load-balances and fails over when an account reaches quota limits.
- **Full Model Support (Claude + Gemini):**
  - `claude-sonnet-4-6` — Default frontier coding model
  - `claude-opus-4-6-thinking` — Deep reasoning with extended thinking blocks
  - `gemini-3.8-flash-medium` — High-speed balanced execution
  - `gemini-3.8-flash-high` — Maximum reasoning depth from Gemini 3.8
  - `gemini-3.8-flash-low` / `gemini-3.5-flash-lite` — Lightweight subagent tasks
- **Gateway Model Discovery:** Integrates directly with Claude Code's `/model` picker so all available models are instantly selectable inside your terminal session.
- **Local Web Dashboard:** Inspect live request logs, token usage, and account health at `http://localhost:8080/`.

---

## ⚡ 1-Click Installation

### Windows
1. Clone this repository or download the ZIP:
   ```bash
   git clone https://github.com/<your-username>/antigravity-claude-bridge.git
   cd antigravity-claude-bridge
   ```
2. Double-click **`setup.bat`** (or run `.\setup.bat` in PowerShell/CMD).
3. The script will:
   - Check Node.js (v20+).
   - Install `@anthropic-ai/claude-code` and `antigravity-claude-proxy` globally.
   - Configure Claude Code settings (`~/.claude/settings.json`) with Gateway Discovery.
   - Install global launchers (`claude-agy`, `claude-gemini`).
   - Open your browser for a 1-time Google sign-in.
   - Launch the proxy background service.

---

### macOS / Linux
1. Clone this repository:
   ```bash
   git clone https://github.com/<your-username>/antigravity-claude-bridge.git
   cd antigravity-claude-bridge
   ```
2. Make executable and run:
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```

---

## 🔄 Multi-Account Load Balancing

To prevent hitting rate limits during heavy coding sessions, link multiple Google accounts:

```bash
# Add a 2nd or 3rd Google account
acc accounts add

# View all connected accounts
acc accounts list
```

### Load Balancing Strategies
Launch the proxy with your preferred strategy:

| Strategy | Command | Best For |
|---|---|---|
| **Hybrid (Default)** | `acc start --strategy=hybrid --fallback` | Auto-failover when an account exhausts quota |
| **Sticky** | `acc start --strategy=sticky` | Maximizes prompt caching by keeping a session on one account |
| **Round-Robin** | `acc start --strategy=round-robin` | Distributes requests evenly across all accounts |

---

## 💻 Running Claude Code & Selecting Models

Once installed, launch Claude Code from **any terminal window**:

### Method 1: Dedicated Quick Launchers
- **Claude Sonnet 4.6 (Antigravity):**
  ```bash
  claude-agy
  ```
- **Gemini 3.8 Flash (Antigravity):**
  ```bash
  claude-gemini
  ```

### Method 2: Standard Command with Dynamic Model Selection
Run standard `claude`:
```bash
claude
```
Inside your active Claude Code session, switch to any model anytime:
```text
/model
```
Because **Gateway Model Discovery** is enabled, all Gemini and Claude models provided by Antigravity will appear in the interactive picker.

---

## 🎛️ Proxy Management Cheat Sheet

| Command | Action |
|---|---|
| `acc status` | Check proxy status and port |
| `acc ui` | Open web dashboard in browser |
| `acc start` | Start background service |
| `acc stop` | Stop background service |
| `acc restart` | Restart proxy service |
| `acc accounts list` | Show all linked Google accounts |
| `acc accounts add` | Link a new Google account |
| `acc accounts remove`| Remove a connected account |

---

## 🛠️ Architecture

```
┌─────────────────────────┐         Anthropic Messages API         ┌────────────────────────────────┐
│     Claude Code CLI     │ ─────────────────────────────────────> │ Antigravity Claude Proxy (acc) │
│ (Terminal Coding Agent) │ <───────────────────────────────────── │     http://localhost:8080      │
└─────────────────────────┘          Streaming SSE Protocol        └───────────────┬────────────────┘
                                                                                   │
                                                      Google OAuth Multi-Account   │ Load Balancing &
                                                      Failover (No API Keys)       │ Failover Rotation
                                                                                   ▼
                                                                   ┌────────────────────────────────┐
                                                                   │   Google Cloud Code Backend    │
                                                                   │   Claude 4.6 & Gemini 3.8      │
                                                                   └────────────────────────────────┘
```

---

## ❓ Troubleshooting

#### "Detected a custom API key in your environment"
Launch with `claude-agy` or ensure `ANTHROPIC_AUTH_TOKEN=test` is present in your environment or `~/.claude/settings.json`.

#### "Invalid model: mimo-pro"
Type `/model` inside Claude Code and select `claude-sonnet-4-6` or `gemini-3.8-flash-medium`.

#### "Proxy is offline"
Run `acc start` to bring the service online.

---

## 🔒 Security & Privacy Notice

- **No credentials in repository:** All user OAuth tokens and session data are stored locally in your OS profile directory (`~/.config/antigravity-proxy/`), completely outside this repository.
- The `.gitignore` is pre-configured to strictly prevent sensitive files, accounts, logs, or databases from ever being committed.
- This project is an independent community bridge and is not affiliated with Anthropic or Google.

---

## 📄 License
Distributed under the [MIT License](LICENSE).
