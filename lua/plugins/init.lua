-----------------------------------------------------------
-- Plugin Definitions
-----------------------------------------------------------

local plugins = {
  -- Start screen
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      require("plugins.alpha")
    end,
  },

  -- Colorscheme
  { 
    "catppuccin/nvim", 
    name = "catppuccin", 
    priority = 1000,
    config = function()
      require("plugins.colorscheme")
    end,
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugins.telescope")
    end,
  },

  -- Syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master", -- pin to the classic API; `main` is a rewrite without nvim-treesitter.configs
    build = ":TSUpdate",
    config = function()
      require("plugins.treesitter")
    end,
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("plugins.nvim-tree")
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("plugins.cmp")
    end,
  },

  -- Tool manager (LSP servers, formatters, debug adapters)
  { "mason-org/mason.nvim" },

  -- LSP configuration (+ Mason integration)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require("plugins.lsp")    -- capabilities + LspAttach keymaps
      require("plugins.mason")  -- install & enable tools via Mason
    end,
  },

    -- LSP signature help (show params while typing)
  {
    "ray-x/lsp_signature.nvim",
    event = "LspAttach",
    config = function()
      require("plugins.signature")
    end,
  },


  -- Auto-pairs (auto-close brackets, braces, quotes)
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("plugins.autopairs")
    end,
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("plugins.dap")
    end,
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      require("plugins.conform")
    end,
  },
}

require("lazy").setup(plugins, {})
