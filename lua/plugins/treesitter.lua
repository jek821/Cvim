-----------------------------------------------------------
-- Treesitter Configuration
-----------------------------------------------------------

require("nvim-treesitter.configs").setup({
  ensure_installed = { "c" },
  highlight = { enable = true },
  indent = { enable = true },
})
