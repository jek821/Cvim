-----------------------------------------------------------
-- Auto-pairs Configuration
-----------------------------------------------------------

require("nvim-autopairs").setup({
  check_ts = true,  -- Use treesitter to check for pairs
  enable_check_bracket_line = false,  -- Don't check if bracket is in same line
})
