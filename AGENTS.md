# AGENTS.md — Neovim Configuration Repository

Guidance for agentic coding agents operating in this Neovim configuration repo.

## Repository Overview

Neovim configuration supporting macOS, Linux (WSL2), and Windows. Uses **lazy.nvim**
for plugin management with a modular, one-plugin-per-file structure.

---

## Build / Lint / Test Commands

There is no Makefile, CI pipeline, or test runner for the config itself. Validation is
done manually inside Neovim.

### Lua formatting (only automated tool)

```sh
# Format all Lua files (requires stylua on PATH)
stylua .

# Format a single file
stylua lua/editing/blink-cmp.lua

# Check without writing (dry run)
stylua --check .
```

Settings live in `stylua.toml`: 100-column width, 2-space indent, double quotes, always
use call parentheses.

### Neovim health checks (run inside Neovim)

```vim
:checkhealth
:checkhealth nvim-treesitter
:checkhealth mason
:checkhealth conform
```

### Plugin management (inside Neovim)

```vim
:Lazy update      " Update all plugins
:Lazy clean       " Remove unused plugins
:Lazy profile     " Check startup time
:Mason            " Manage LSP/DAP/formatter installations
:TSUpdate         " Update treesitter parsers
```

There is no "single test" command — config correctness is verified by restarting Neovim
and running `:checkhealth`.

---

## Code Style Guidelines

### Lua Formatting (stylua)

- **Column width:** 100 characters
- **Indentation:** 4 spaces (no tabs)
- **Strings:** double quotes preferred (`AutoPreferDouble`)
- **Call parentheses:** always include them
- Run `stylua .` before committing any Lua changes.

### Imports / Requires

- Use dot-notation paths relative to `lua/`: `require("utils.constants")` → `lua/utils/constants/init.lua`
- Use kebab-case filenames: `get-values-on-os.lua`, `blink-cmp.lua`
- Always `require` at the top of a function or config block, not at module level, unless
  the dependency is guaranteed to be loaded (lazy.nvim handles ordering).
- Shared constants belong in `lua/utils/constants/`; do not inline magic strings or
  repeated tables.

### Plugin File Structure

Each plugin lives in exactly one file inside the appropriate category directory and
returns a lazy.nvim spec table (or array of tables):

```lua
-- Minimal spec — lazy.nvim calls require("plugin").setup(opts) automatically
return {
    "author/plugin-name",
    opts = { ... },
}

-- Full spec — use config when setup requires custom logic
return {
    "author/plugin-name",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "other/dep" },
    config = function(_, opts)
        require("plugin").setup(opts)
        -- additional setup logic
    end,
    keys = { ... },
}

-- Multiple related plugins in one file
return {
    { "plugin/one", opts = {} },
    { "plugin/two", config = function() ... end },
}
```

**Rules:**

- Never use both `opts` and `config` in the same spec — pick one.
- Simple plugins: prefer `opts = {}` (less boilerplate).
- Complex plugins: use `config = function(_, opts) ... end`.
- One concern per file; if a helper plugin is trivially small, it may live in the same
  file as the plugin that depends on it.

### Adding a New Plugin

1. Create `lua/chalupa/plugin_name.lua` returning a lazy.nvim spec.
2. No manual registration needed — lazy.nvim scans all files in each category dir.
3. Prefer default plugin configuration unless there's a specific reason to override.

### Naming Conventions

- **Lua files:** snake_case (`blink_cmp.lua`, `get_values_on_os.lua`)
- **Lua modules/variables:** snake_case (`local my_var`, `local get_values_on_os`)
- **Constants:** UPPER_SNAKE_CASE (`KEYBINDING_OPTS`, `DARWIN`)
- **Which-key group prefixes:** single letter after `<leader>`

### Error Handling

- Wrap optional feature requires in `pcall` when the module may not be present:
  ```lua
  local ok, plugin = pcall(require, "optional-plugin")
  if not ok then return end
  ```
- For LSP callbacks and DAP configs, use `vim.notify` with a level:
  ```lua
  vim.notify("Message", vim.log.levels.WARN)
  ```

### Globals Allowed by .luarc.json

The Lua LSP is configured to recognise these as globals (do not `require` them):
`vim`, `require`, `on`, `enable`, `pairs`, `ipairs`, `pcall`
