-----------------------------------------------------------
-- Main init.lua - Entry point for your Neovim config
-----------------------------------------------------------
-----------------------------------------------------------
-- Bootstrap lazy.nvim
-----------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.loop or vim.uv).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-----------------------------------------------------------
-- Load core configuration
-----------------------------------------------------------
require("core.options")    -- Basic vim settings
require("core.keymaps")    -- Keybindings
require("core.autocmds")   -- Autocommands

-----------------------------------------------------------
-- Load plugins
-----------------------------------------------------------
require("plugins")


vim.opt.clipboard = "unnamedplus"
