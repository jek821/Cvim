-----------------------------------------------------------
-- Colorscheme Configuration
-----------------------------------------------------------

require("catppuccin").setup()
vim.cmd.colorscheme("catppuccin")


-- Automatically set colorscheme on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function ()
    vim.cmd.colorscheme("catppuccin-frappe")
  end,
})
