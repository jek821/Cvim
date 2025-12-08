-----------------------------------------------------------
-- Auto-pairs Configuration
-----------------------------------------------------------

require("nvim-autopairs").setup({
  check_ts = true,  -- Use treesitter to check for pairs
  enable_check_bracket_line = false,  -- Don't check if bracket is in same line
})

-- Integration with nvim-cmp (so pairs work with autocompletion)
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
