# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a **dotfiles repository** (`sgrumo/dotfiles`) tracking personal configuration for macOS development tools. Remote uses a custom SSH alias: `git@github.com-sgrumo:sgrumo/dotfiles.git`.

## Key Configurations

### Neovim (`nvim/`)

Based on **kickstart.nvim** with heavy customization. Uses **lazy.nvim** as plugin manager.

**Entry flow:** `init.lua` → sets leader key (space), bootstraps lazy.nvim → loads `lua/config/` (options, keymaps, autocmds) and `lua/plugins/` (one file per plugin or group).

**Plugin architecture:** Each file in `lua/plugins/` returns a lazy.nvim plugin spec table. Plugins are auto-discovered by lazy.nvim from this directory.

**Key tooling choices:**
- Completion: `blink.cmp` (not nvim-cmp)
- Snippets: `LuaSnip`
- Formatter: `conform.nvim` (stylua for Lua, prettier for web)
- Linter: `nvim-lint` (markdownlint)
- Navigation: `telescope.nvim` + `flash.nvim`
- File explorer: `neo-tree.nvim`
- Git: `gitsigns.nvim`, `vim-fugitive`, `diffview.nvim`, `conventional-commits.nvim`
- Theme: `tokyodark.nvim`
- Language-specific: `elixir-tools.nvim` (NextLS/ElixirLS)

**Lua style:** `.stylua.toml` — 160 char line width, 2-space indent, single quotes.

**Plugin lock file:** `lazy-lock.json` is tracked in git. Update it after adding/changing plugins.

### Zellij (`zellij/`)

Terminal multiplexer config in KDL format (`config.kdl`). Uses tmux-style keybinding modes (Ctrl+P for panes, Ctrl+T for tabs, Ctrl+S for scroll). Has a `zellij-forgot` plugin for keybinding reference (Ctrl+Y).

### Zed (`zed/`)

Minimal config — mostly AI conversation history and prompt library databases.

### Raycast (`raycast/`)

Extensions: VS Code/Cursor project launcher, Spotify player, Arc browser integration. Each extension has its own directory with `package.json` manifest.

### Git (`git/`)

Global git ignore at `git/ignore` — currently ignores `.claude/settings.local.json`.
