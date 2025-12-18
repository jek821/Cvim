-----------------------------------------------------------
-- LSP Signature Configuration
-----------------------------------------------------------

require("lsp_signature").setup({
  hint_enable = false,      -- no inline virtual text
  floating_window = true,   -- popup window
  handler_opts = {
    border = "rounded",
  },
})

