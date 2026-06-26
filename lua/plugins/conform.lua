-----------------------------------------------------------
-- Conform - Formatting Configuration
-----------------------------------------------------------

require("conform").setup({
  -----------------------------------------------------------
  -- Formatters by filetype
  -----------------------------------------------------------
  formatters_by_ft = {
    -- C/C++: format with clang-format (reads the project's .clang-format),
    -- fall back to clangd's LSP formatter if the binary isn't found.
    c = { "clang-format", "lsp_fallback" },
    cpp = { "clang-format", "lsp_fallback" },
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
