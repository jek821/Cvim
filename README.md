# Neovim Configuration

A modular Neovim configuration with LSP, debugging, and autocompletion support for C, Python, and Go.

## Features

- 🎨 Catppuccin colorscheme
- 🔍 Fuzzy file finding with Telescope
- 🌳 File explorer with nvim-tree
- 📝 LSP support for C, Python, and Go
- 🐛 Debugging support for C
- ✨ Auto-completion with nvim-cmp
- 🔧 Auto-closing brackets and quotes
- 💾 Auto-save on buffer leave

## Required Dependencies

- Neovim >= 0.9.0
- Node.js and npm
- gcc
- gdb
- clangd
- ripgrep

## Language Server Dependencies

- **Python**: `pyright` (install via npm)
- **Go**: `gopls` (install via `go install golang.org/x/tools/gopls@latest`)

## PATH Configuration

Add Go binaries to your PATH in `~/.bashrc` or `~/.zshrc`:
```bash
export PATH=$PATH:$(go env GOPATH)/bin
```

## Debugging Support

Currently, only C debugging is fully configured and working.

Python and Go debugging support is not yet implemented.

## Troubleshooting

### LSP not working
```vim
:LspInfo  " Check if LSP is attached
:LspRestart  " Restart the LSP
```

### Plugins not installing
```vim
:Lazy sync  " Sync plugins
:Lazy clean  " Clean unused plugins
:Lazy update  " Update all plugins
```

### Completion not working
1. Ensure LSP is running (`:LspInfo`)
2. Try restarting LSP (`:LspRestart`)

