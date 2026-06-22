<div align="center">
  <img src="https://user-images.githubusercontent.com/292349/213446185-2db63fd5-8c84-459c-9f04-e286382d6e80.png">
</div>

<hr>

My daily-driver Neovim setup, built on [LazyVim](https://lazyvim.github.io/) and tuned for work across Python, Go, Kubernetes, Terraform, and more.

## What You Get

- **Catppuccin theme** that auto-switches between light (latte) and dark (macchiato) based on your macOS appearance
- **13 language extras** with LSP, formatting, linting, and snippets out of the box
- **Super-tab completion** via blink.cmp — tab through suggestions, snippets expand inline
- **Built-in tool terminals** for K9s, lazydocker, Bucky, and GH-Dash — each binding only registers if the binary is on your `$PATH`
- **Auto-save** on focus/buffer leave — write all buffers when you switch away or change buffers
- **Database UI** via Dadbod, with a custom **Trino** adapter for running queries without leaving the editor
- **Git blame** inline with commit summaries, dates, and authors
- **Custom scratch buffers** — pick a filetype, or browse/preview/delete existing scratches

## Prerequisites

| Tool             | Purpose            | Install                                       |
| ---------------- | ------------------ | --------------------------------------------- |
| **Neovim 0.11+** | Editor             | [neovim.io](https://neovim.io)                |
| **Git**          | Plugin management  | Required                                      |
| **ripgrep**      | Fast search        | `brew install ripgrep`                        |
| **fd**           | File finding       | `brew install fd`                             |
| **yamlfmt**      | YAML formatting    | `:MasonInstall yamlfmt` (auto)                |
| **yamllint**     | YAML linting       | `:MasonInstall yamllint` (auto)               |
| **sqruff**       | SQL formatting     | `brew install sqruff` + `~/.config/sqruff/.sqruff` |
| **k9s**          | Kubernetes TUI     | Optional — `brew install k9s`                 |
| **lazydocker**   | Docker TUI         | Optional — `brew install lazydocker`          |
| **bucky**        | Terminal tool      | Optional — opens via `<leader>tb` if present  |
| **gh-dash**      | GitHub dashboard   | Optional — `brew install gh-dash`             |

> Most LSPs, formatters, and linters install automatically through Mason when their language extra loads. Python's `ty` is provided here via [mise](https://mise.jdx.dev/).

## Install

Make a backup of your current Neovim files:

```bash
# required
mv ~/.config/nvim{,.bak}

# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
```

Clone the repo:

```bash
git clone https://github.com/mrpbennett/lazyvim-config.git ~/.config/nvim
```

Start nvim

```bash
nvim
```

## Project Layout

```
~/.config/nvim/
├── init.lua                  # Entry point — bootstraps lazy.nvim + Trino dadbod adapter
├── lazyvim.json              # Enabled LazyVim extras
├── lazy-lock.json            # Pinned plugin versions
├── stylua.toml               # Lua formatter settings
│
├── snippets/                 # Custom LuaSnip snippets
│   ├── kubernetes.json       # K8s manifests (deployment, service, ingress, etc.)
│   ├── python.json           # main, requests, logging, SFTP, classes
│   ├── javascript.json       # React, TypeScript, fetch patterns (also used for TS)
│   ├── dockerfile.json       # Production Dockerfile with uv
│   └── package.json          # Snippet registration
│
└── lua/
    ├── config/
    │   ├── lazy.lua          # Plugin manager setup
    │   ├── options.lua       # Editor options + macOS dark mode detection
    │   ├── keymaps.lua       # Custom keybindings + conditional tool terminals
    │   └── autocmds.lua      # Auto-save autocommand (FocusLost/BufLeave)
    ├── plugins/
    │   ├── colorscheme.lua   # Catppuccin + alternate themes
    │   ├── codediff.lua      # Side-by-side diff viewer
    │   ├── git-blame.lua     # Inline git blame
    │   ├── nimbleapi.lua     # nimbleapi.nvim (HTTP/API client)
    │   └── default-tweaks/   # Overrides of LazyVim default plugins
    │       ├── blink.lua          # Completion (super-tab preset)
    │       ├── conform.lua        # Formatters (yamlfmt, sqruff)
    │       ├── flash.lua          # Flash motions (S disabled, char jump labels)
    │       ├── lualine.lua        # Status line styling
    │       ├── nvim-lint.lua      # Linter config (yamllint)
    │       ├── nvim-lsp.lua       # yamlls schemaStore + k8s schema mapping
    │       ├── snacks.lua         # Dashboard, picker, dim, image, scratch keys
    │       ├── vim-dadbod-ui.lua  # Dadbod UI + Trino table helpers
    │       └── which-key.lua      # Tool group registration
    └── utils/
        └── snacks/
            └── scratch.lua   # Custom scratch-buffer picker helpers
```

## Language Support

This config enables 13 LazyVim language extras. Here's what's wired up (custom = overridden in this config, not the LazyVim default):

| Language      | LSP                       | Formatter            | Linter            |
| ------------- | ------------------------- | -------------------- | ----------------- |
| Python        | ty (Astral)               | ruff                 | ruff              |
| Go            | gopls                     | gofumpt + goimports  | golangci-lint     |
| TypeScript/JS | vtsls                     | prettier             | eslint            |
| YAML          | yamlls                    | yamlfmt _(custom)_   | yamllint _(custom)_ |
| JSON          | jsonls                    | prettier             | —                 |
| TOML          | taplo                     | taplo                | —                 |
| SQL           | — (Dadbod completion)     | sqruff _(custom)_    | —                 |
| Docker        | dockerls + docker_compose | —                    | —                 |
| Terraform     | terraformls               | terraform fmt        | —                 |
| Helm          | helm_ls                   | —                    | —                 |
| Markdown      | marksman                  | prettier             | —                 |
| Java          | jdtls                     | —                    | —                 |
| Ember         | ember-language-server     | prettier             | —                 |
| Lua           | lua_ls (via LazyVim)      | stylua               | —                 |

> **Note:** Python uses [ty](https://github.com/astral-sh/ty), Astral's type checker — not pyright. Set via `vim.g.lazyvim_python_lsp = "ty"` in `options.lua`. `ruff` handles both formatting and linting.

> Rust and Tailwind are **not** enabled — add `lazyvim.plugins.extras.lang.rust` / `.tailwind` to `lazyvim.json` if you want them.

## Keybindings

### Custom Mappings

| Key               | Mode                   | What it does       |
| ----------------- | ---------------------- | ------------------ |
| `jj` / `jk`       | Insert                 | Escape to normal mode |
| `Alt+j` / `Alt+k` | Normal, Insert, Visual | Move line(s) up/down  |
| `<leader>.`       | Normal                 | New scratch (pick filetype) |
| `<leader>S`       | Normal                 | Select existing scratch buffer |

Arrow keys are disabled in normal mode (they echo a reminder to use `hjkl`).

### Tool Terminals (`<leader>t`)

These only appear if the tool is installed on your system:

| Key          | Tool             |
| ------------ | ---------------- |
| `<leader>tk` | K9s (Kubernetes) |
| `<leader>td` | lazydocker       |
| `<leader>tb` | Bucky            |
| `<leader>tg` | GH-Dash          |

### Handy LazyVim Defaults

| Key          | Action                                         |
| ------------ | ---------------------------------------------- |
| `<leader>`   | Which-key popup (shows all available bindings) |
| `<leader>ff` | Find files                                     |
| `<leader>sg` | Live grep                                      |
| `<leader>gb` | Git branches                                   |
| `<leader>gc` | Git commits                                    |
| `<leader>xx` | Toggle Trouble diagnostics                     |

## Snippets

Custom snippets live in `snippets/` and are loaded via LuaSnip.

**Kubernetes** (`k8s-` prefix in YAML files): deployment, service, configmap, secret, ingress, statefulset, pvc, job, cronjob.

**Python**: `pmain` (main boilerplate), `req` (requests call), `sftp_` (paramiko SFTP), `logger` (logging setup), `classpy` (class template).

**Dockerfile**: `dockerfile-uv` — production multi-stage build with uv package manager.

**JavaScript/TypeScript**: a large set covering React components, TypeScript types, fetch patterns, and more (shared `javascript.json`).

## Database Integration

DB work runs through [vim-dadbod](https://github.com/tpope/vim-dadbod) + dadbod-ui (the SQL extra). This config adds a custom **Trino** adapter so `trino://` URLs aren't rewritten to `presto://`:

- `init.lua` registers the Trino adapter (`vim.g.db_adapters`, `vim.g.db_adapter_trino`).
- `lua/plugins/default-tweaks/vim-dadbod-ui.lua` adds Trino-specific table helpers (List / Columns / Count / Describe) and disables execute-on-save.

Connections are supplied through standard dadbod mechanisms (e.g. `vim.g.dbs` or a `$DBUI_URL`-style env var) — they are **not** committed to the repo.

- `:DBUI` opens the database browser
- Auto-completion for table/column names in SQL buffers (via blink + dadbod source)

See [lazyvim.org/extras/lang/sql](https://www.lazyvim.org/extras/lang/sql) for details.

## Notable Design Decisions

- **Auto-save on leave** — writes all buffers on `FocusLost` and `BufLeave` (augroup-guarded). Switch window/app or change buffers and your work is saved.
- **macOS appearance sync** — reads `AppleInterfaceStyle` at startup to pick the light/dark Catppuccin flavour.
- **Conditional tool keymaps** — K9s, lazydocker, and Bucky bindings register only when their binaries are on `$PATH`; GH-Dash works with either a `gh-dash` binary or the `gh dash` CLI extension.
- **yamlfmt over prettier for YAML** — better Kubernetes support (preserves comments, handles multi-doc files). `nvim-lsp.lua` also wires k8s manifest globs to the YAML schema.
- **sqruff for SQL** — formats via a small `sh -c` wrapper that strips the extra trailing newline sqruff emits.
- **Prettier runs without config** — `lazyvim_prettier_needs_config = false`, so it formats even in projects without `.prettierrc`.
- **No swapfile** — `vim.opt.swapfile = false`.

## Customization

### Add a plugin

Drop a file in `lua/plugins/`:

```lua
-- lua/plugins/myplugin.lua
return {
  "author/plugin-name",
  opts = {},
}
```

To override a LazyVim default plugin's options, add a spec under `lua/plugins/default-tweaks/`.

### Add a keybinding

Edit `lua/config/keymaps.lua`:

```lua
vim.keymap.set("n", "<leader>my", function()
  -- your action here
end, { desc = "My custom thing" })
```

### Change the theme

Edit `lua/plugins/colorscheme.lua`. Alternates already installed (lazy-loaded): **dracula**, **boo-berry**, **gruvbox**, **vault**, and **everforest** — set the `LazyVim` `colorscheme` opt to switch.

## Quick Reference

| Command        | What it does                            |
| -------------- | --------------------------------------- |
| `:Lazy`        | Open plugin manager                     |
| `:Lazy sync`   | Update all plugins                      |
| `:Mason`       | Manage LSP servers, formatters, linters |
| `:checkhealth` | Run health checks                       |
| `<leader>cf`   | Format current buffer (conform)         |
| `:DBUI`        | Open database UI                        |
| `:CodeDiff`    | Side-by-side diff viewer                |

## Troubleshooting

**Plugins acting up?**

```
:Lazy clean
:Lazy sync
```

**LSP not working?**

```
:LspInfo        -- see what's attached
:LspRestart     -- restart servers
:Mason          -- check if the server is installed
```

---

Built on [LazyVim](https://lazyvim.github.io/) with [Catppuccin](https://github.com/catppuccin/nvim).
