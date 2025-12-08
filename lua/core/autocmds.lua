-----------------------------------------------------------
-- Autocommands
-----------------------------------------------------------

-----------------------------------------------------------
-- Auto-save when leaving buffer
-----------------------------------------------------------
vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "*",
  callback = function()
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
      vim.cmd("silent! write")
    end
  end,
})
