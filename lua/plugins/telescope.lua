-----------------------------------------------------------
-- Telescope Configuration
-----------------------------------------------------------

local actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-q>"] = actions.close,
        ["<C-s>"] = actions.select_vertical,
      },
      n = {
        ["<C-q>"] = actions.close,
        ["<C-s>"] = actions.select_vertical,
      },
    },
  },
})
