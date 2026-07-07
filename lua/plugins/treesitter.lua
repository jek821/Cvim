---------------------------------------------------------
-- Treesitter Configuration
---------------------------------------------------------
require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "python" },
  highlight = { enable = true },
  indent = { enable = true },
})
