-----------------------------------------------------------
-- Mason - Tool manager (LSP servers, formatters, debuggers)
-----------------------------------------------------------

require("mason").setup()

-----------------------------------------------------------
-- LSP servers
-- Mason installs these and (as of mason-lspconfig 2.0) enables
-- them automatically via vim.lsp.enable. Server-specific settings
-- live in plugins/lsp.lua via vim.lsp.config.
-----------------------------------------------------------
require("mason-lspconfig").setup({
  ensure_installed = {
    "clangd",  -- C/C++
    "pyright", -- Python
  },
})

-----------------------------------------------------------
-- Non-LSP tools (formatters + debug adapters)
-----------------------------------------------------------
require("mason-tool-installer").setup({
  ensure_installed = {
    "clang-format", -- C/C++ formatter   (conform)
    "ruff",         -- Python formatter  (conform)
    "debugpy",      -- Python debugger   (dap)
  },
})
