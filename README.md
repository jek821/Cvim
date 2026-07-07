# Neovim Configuration

A focused Neovim setup for **C and Python** — LSP, formatting, completion, and
debugging, with all tooling installed and managed automatically by Mason.

## Features

- 🎨 Catppuccin colorscheme
- 🔍 Fuzzy file finding & live grep with Telescope
- 🌳 File explorer with nvim-tree
- 🧠 Language support: **clangd** (C) & **pyright** (Python) — diagnostics,
  go-to-definition, hover, rename
- 🌲 Treesitter syntax highlighting & indentation for C and Python
- ✨ Auto-completion with nvim-cmp + LuaSnip
- ✍️ LSP signature help while typing (lsp_signature)
- 🧹 Format-on-save: clang-format (C, reads the project's `.clang-format`) & ruff (Python)
- 🐛 Debugging (nvim-dap + dap-ui): gdb (C) & debugpy (Python)
- 📦 Tool management with **Mason** — LSP servers, formatters and debug
  adapters install automatically on first launch
- 🔧 Auto-closing brackets/quotes (autopairs)
- 🖥️ Toggleable integrated terminal (`<leader>tt` / `<leader>tk`)
- 📋 Built-in keybinding cheatsheet (`<leader>?`)
- 💾 Auto-save on buffer leave

## Required Dependencies

Only a few things need to be on your system — Mason installs the LSP servers,
formatters and debug adapters (clangd, pyright, clang-format, ruff, debugpy)
for you on first launch.

- **Neovim >= 0.11** (uses the `vim.lsp.config` / `vim.lsp.enable` API)
- git
- gcc (compile C) and gdb (debug C)
- python3 (run/debug Python)
- node (Mason uses it to install pyright)
- ripgrep (for Telescope live grep)
- A [Nerd Font](https://www.nerdfonts.com/) (optional, for file-tree/completion icons)

Plugins are managed by [lazy.nvim](https://github.com/folke/lazy.nvim), which
bootstraps itself on first launch. Language tooling is managed by
[Mason](https://github.com/mason-org/mason.nvim) — run `:Mason` to see or
update the installed tools.

## How clangd finds the project

clangd reads compilation flags from a `compile_flags.txt` or
`compile_commands.json` at (or above) the source file, and formatting rules from
a `.clang-format` file. These live **in the project repo**, not in this config,
so nvim and VS Code get identical diagnostics and formatting from the same
clangd binary.

## Keybindings

Leader key is `<space>`. Press `<leader>?` in Neovim for the full cheatsheet.
Highlights:

| Key | Action |
| --- | --- |
| `<leader>ff` / `<leader>fg` | Find files / live grep (Telescope) |
| `<leader>e` | Toggle file explorer |
| `<leader>tt` / `<leader>tk` | Toggle terminal (processes survive) / kill it |
| `<leader>cc` | Compile current C file with `-g` (for debugging) |
| `gd` / `gr` / `K` | Go to definition / references / hover docs |
| `<leader>rn` / `<leader>ca` | Rename symbol / code actions |
| `]d` / `[d` / `<leader>d` | Next / previous / show diagnostic |
| `<leader>b` / `f5` | Toggle breakpoint / start-continue debugging |

## Debugging

**C** — set breakpoints with `<leader>b`, compile with `<leader>cc` (adds
`-g`), then start the debugger with `f5` and enter the path to the executable.

**Python** — set breakpoints with `<leader>b`, then start the debugger with
`f5`; it launches the current file directly (no compile step).

## Troubleshooting

### LSP not working
```vim
:checkhealth lsp   " Inspect attached LSP clients and config
:LspRestart        " Restart the language server (clangd / pyright)
:Mason             " Manage LSP servers, formatters, debug adapters
```

### Plugins not installing
```vim
:Lazy sync    " Sync plugins
:Lazy clean   " Clean unused plugins
:Lazy update  " Update all plugins
```
