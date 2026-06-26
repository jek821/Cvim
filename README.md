# Neovim Configuration

A modular Neovim configuration with LSP, formatting, debugging, and
autocompletion support for C/C++, Python, Go, and web (JavaScript/TypeScript/React).

## Features

- 🎨 Catppuccin colorscheme
- 🔍 Fuzzy file finding & live grep with Telescope
- 🌳 File explorer with nvim-tree
- 🧠 LSP support for C/C++, Python, Go, and JavaScript/TypeScript
- 🌲 Treesitter syntax highlighting & indentation
- ✨ Auto-completion with nvim-cmp + LuaSnip
- ✍️ LSP signature help while typing (lsp_signature)
- 🧹 Format-on-save with conform.nvim
- 🐛 Debugging support for C (nvim-dap + dap-ui)
- 🔧 Auto-closing brackets/quotes (autopairs) and HTML/JSX tags (ts-autotag)
- 🖥️ Integrated terminal split (`<leader>tt`)
- 📋 Built-in keybinding cheatsheet (`<leader>?`)
- 💾 Auto-save on buffer leave

## Required Dependencies

- **Neovim >= 0.11** (uses the `vim.lsp.config` / `vim.lsp.enable` API)
- git
- Node.js and npm
- gcc
- gdb
- ripgrep (for Telescope live grep)
- A [Nerd Font](https://www.nerdfonts.com/) (optional, for file-tree and completion icons)

Plugins are managed by [lazy.nvim](https://github.com/folke/lazy.nvim), which
bootstraps itself on first launch.

## Language Servers

| Language | Server | Install |
| --- | --- | --- |
| C/C++ | `clangd` | Ships with the clang/LLVM package (`dnf install clang-tools-extra`) |
| Python | `pyright` | `npm install -g pyright` |
| Go | `gopls` | `go install golang.org/x/tools/gopls@latest` |
| JS/TS/TSX | `ts_ls` | `npm install -g typescript typescript-language-server` |

## Formatters (format-on-save via conform.nvim)

| Language | Formatter | Install |
| --- | --- | --- |
| C/C++ | `clang-format` | Ships with clang |
| Python | `black` | `pip install black` |
| Go | `gofmt`, `goimports` | `gofmt` ships with Go; `go install golang.org/x/tools/cmd/goimports@latest` |
| JS/TS/CSS/HTML/JSON | `prettier` | `npm install -g prettier` |

If a formatter isn't installed, conform falls back to the LSP's formatter.

## PATH Configuration

Add Go binaries to your PATH in `~/.bashrc` or `~/.zshrc`:
```bash
export PATH=$PATH:$(go env GOPATH)/bin
```
Then refresh with `source ~/.bashrc`.

## Keybindings

Leader key is `<space>`. Press `<leader>?` in Neovim to open the full cheatsheet.
A few highlights:

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

## Debugging Support

Currently, only **C** debugging is fully configured (nvim-dap + dap-ui).
Python and Go debugging are not yet implemented.

Workflow: set breakpoints with `<leader>b`, compile with `<leader>cc`, then
start the debugger with `f5` and enter the path to the executable.

## Troubleshooting

### LSP not working
```vim
:checkhealth lsp   " Inspect attached LSP clients and config (replaces :LspInfo on 0.11+)
:LspRestart        " Restart the LSP
```

### Plugins not installing
```vim
:Lazy sync    " Sync plugins
:Lazy clean   " Clean unused plugins
:Lazy update  " Update all plugins
```

### Completion not working
1. Ensure the LSP is attached (`:checkhealth lsp`)
2. Try restarting the LSP (`:LspRestart`)
