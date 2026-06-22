Perform a comprehensive audit of my Neovim configuration in this dotfiles repo. For each step, use TodoWrite to track progress:

1. **Plugin Spec Validation**: Read every plugin spec in `lua/plugins/`. For each plugin, run `nvim --headless` commands to verify it actually loads without errors. Check that `opts` tables use valid configuration keys by reading the plugin's actual source or docs.

2. **LSP Health Check**: Run `nvim --headless -c 'lua for _,c in ipairs(vim.lsp.get_clients()) do print(c.name, c.config.cmd[1]) end' -c 'qa'` against a sample Python and Go file. Verify each configured LSP server resolves to a real binary on PATH or in Mason's install directory.

3. **Keymap Conflict Detection**: Extract all keymaps from my config files and check for duplicates or overwrites. Flag any keymap that shadows a critical default.

4. **Mason Package Names**: Cross-reference every Mason ensure_installed entry against `mason-registry` to verify package names are current and valid.

5. **Config Override Issues**: Identify any place where a plugin's default opts might silently overwrite my customizations (like the LazyVim/snacks issue I hit before). Suggest the function-based `opts` pattern where needed.

Produce a markdown report with: ✅ passing checks, ⚠️ warnings, ❌ errors with exact fix suggestions. Apply any safe, unambiguous fixes automatically and leave the rest as a TODO list.
