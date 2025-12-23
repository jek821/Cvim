-----------------------------------------------------------
-- Conform - Formatting Configuration
-----------------------------------------------------------

require("conform").setup({
  -----------------------------------------------------------
  -- Formatters by filetype
  -----------------------------------------------------------
  formatters_by_ft = {
    -- C/C++: try clang-format first, fallback to LSP
    c = { "clang-format", "lsp_fallback" },
    cpp = { "clang-format", "lsp_fallback" },
    
    -- Python: try black first, fallback to LSP
    python = { "black", "lsp_fallback" },
    
    -- Go: use gofmt and goimports, fallback to LSP
    go = { "gofmt", "goimports", "lsp_fallback" },
  },

  -----------------------------------------------------------
  -- Format on save
  -----------------------------------------------------------
  format_on_save = {
    -- Timeout in milliseconds
    timeout_ms = 500,
    -- Use LSP formatting if no formatter is available
    lsp_fallback = true,
  },
})
