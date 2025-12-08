-----------------------------------------------------------
-- Nvim-tree Configuration
-----------------------------------------------------------

local function on_attach(bufnr)
  local api = require("nvim-tree.api")
  
  -- Default mappings
  api.config.mappings.default_on_attach(bufnr)
  
  -- Custom mappings
  vim.keymap.set('n', '<C-x>', api.node.open.horizontal, { buffer = bufnr, noremap = true })
  vim.keymap.set('n', '<C-s>', api.node.open.vertical, { buffer = bufnr, noremap = true })
end

require("nvim-tree").setup({
  renderer = {
    icons = {
      show = {
        file = false,
        folder = false,
        folder_arrow = false,
        git = false,
      },
    },
  },
  on_attach = on_attach,
})
