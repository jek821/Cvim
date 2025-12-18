-----------------------------------------------------------
-- Keymaps
-----------------------------------------------------------

local keymap = vim.keymap.set
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-----------------------------------------------------------
-- General keymaps
-----------------------------------------------------------
-- Quick escape from insert mode
keymap("i", "qq", "<Esc>", { noremap = true })

-- Save and quit
keymap("n", "<leader>w", ":w<CR>")
keymap("n", "<leader>q", ":q<CR>")

-----------------------------------------------------------
-- Window navigation
-----------------------------------------------------------
-- Normal mode
keymap("n", "<C-h>", "<C-w>h", { noremap = true })
keymap("n", "<C-j>", "<C-w>j", { noremap = true })
keymap("n", "<C-k>", "<C-w>k", { noremap = true })
keymap("n", "<C-l>", "<C-w>l", { noremap = true })

-- Terminal mode
keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true })
keymap("t", "<C-q>", "<C-\\><C-n>:q<CR>", { noremap = true })
keymap("t", "<C-h>", "<C-\\><C-n><C-w>h", { noremap = true })
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", { noremap = true })
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", { noremap = true })
keymap("t", "<C-l>", "<C-\\><C-n><C-w>l", { noremap = true })

-----------------------------------------------------------
-- Terminal
-----------------------------------------------------------
keymap("n", "<leader>tt", function()
  vim.cmd("botright 15split | terminal")
end)

-----------------------------------------------------------
-- File explorer
-----------------------------------------------------------
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true })

-----------------------------------------------------------
-- Cheatsheet
-----------------------------------------------------------
keymap("n", "<leader>?", ":vsplit ~/.config/nvim/cheatsheet.txt<CR>", { noremap = true })

-----------------------------------------------------------
-- Telescope (fuzzy finder)
-----------------------------------------------------------
keymap("n", "<leader>ff", function()
  require("telescope.builtin").find_files()
end, { desc = "Find files" })

keymap("n", "<leader>fg", function()
  require("telescope.builtin").live_grep()
end, { desc = "Live grep" })

-----------------------------------------------------------
-- Debugging (DAP)
-----------------------------------------------------------
keymap("n", "<F5>", function() require("dap").continue() end, { desc = "Debug: Start/Continue" })
keymap("n", "<F10>", function() require("dap").step_over() end, { desc = "Debug: Step Over" })
keymap("n", "<F11>", function() require("dap").step_into() end, { desc = "Debug: Step Into" })
keymap("n", "<F12>", function() require("dap").step_out() end, { desc = "Debug: Step Out" })
keymap("n", "<leader>b", function() require("dap").toggle_breakpoint() end, { desc = "Debug: Toggle Breakpoint" })
keymap("n", "<leader>dr", function() require("dap").repl.open() end, { desc = "Debug: Open REPL" })
keymap("n", "<leader>dt", function() require("dapui").toggle() end, { desc = "Debug: Toggle UI" })

-----------------------------------------------------------
-- Compile helper for C (compile with -g flag)
-----------------------------------------------------------
keymap("n", "<leader>cc", function()
  local file = vim.fn.expand("%")
  local output = vim.fn<ScrollWheelUp>expand("%:r")
  vim.cmd("botright 10split | terminal gcc -g " .. file .. " -o " .. output)
end, { desc = "Compile C file with -g (debug)" })
