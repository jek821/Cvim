# Neovim Configuration

A focused Neovim setup for **C programming** — LSP, formatting, completion, and
debugging via clangd, mirroring a clangd-based VS Code workflow.

## Features

- 🎨 Catppuccin colorscheme
- 🔍 Fuzzy file finding & live grep with Telescope
- 🌳 File explorer with nvim-tree
- 🧠 C language support via **clangd** (diagnostics, go-to-definition, hover, rename)
- 🌲 Treesitter syntax highlighting & indentation for C
- ✨ Auto-completion with nvim-cmp + LuaSnip
- ✍️ LSP signature help while typing (lsp_signature)
- 🧹 Format-on-save with clang-format (reads the project's `.clang-format`)
- 🐛 C debugging (nvim-dap + dap-ui)
- 🔧 Auto-closing brackets/quotes (autopairs)
- 🖥️ Integrated terminal split (`<leader>tt`)
- 📋 Built-in keybinding cheatsheet (`<leader>?`)
- 💾 Auto-save on buffer leave

## Required Dependencies

- **Neovim >= 0.11** (uses the `vim.lsp.config` / `vim.lsp.enable` API)
- git
- gcc
- gdb
- **clangd** and **clang-format** — `dnf install clang-tools-extra` (Fedora)
- ripgrep (for Telescope live grep)
- A [Nerd Font](https://www.nerdfonts.com/) (optional, for file-tree/completion icons)

Plugins are managed by [lazy.nvim](https://github.com/folke/lazy.nvim), which
bootstraps itself on first launch.

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
| `<leader>tt` | Open terminal in bottom split |
| `<leader>cc` | Compile current C file with `-g` (for debugging) |
| `gd` / `gr` / `K` | Go to definition / references / hover docs |
| `<leader>rn` / `<leader>ca` | Rename symbol / code actions |
| `]d` / `[d` / `<leader>d` | Next / previous / show diagnostic |
| `<leader>b` / `f5` | Toggle breakpoint / start-continue debugging |

## Debugging (C)

Set breakpoints with `<leader>b`, compile with `<leader>cc` (adds `-g`), then
start the debugger with `f5` and enter the path to the executable.

## Troubleshooting

### LSP not working
```vim
:checkhealth lsp   " Inspect attached LSP clients and config
:LspRestart        " Restart clangd
```

### Plugins not installing
```vim
:Lazy sync    " Sync plugins
:Lazy clean   " Clean unused plugins
:Lazy update  " Update all plugins
```
