-----------------------------------------------------------
-- LSP Configuration
-----------------------------------------------------------

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-----------------------------------------------------------
-- Start clangd for C/C++ files
-----------------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function(ev)
    vim.lsp.start({
      name = "clangd",
      cmd = { "clangd" },
      root_dir = vim.fs.root(ev.buf, { "compile_commands.json", ".git" }) or vim.fn.getcwd(),
      capabilities = capabilities,
    })
  end,
})

-----------------------------------------------------------
-- Start pyright for Python files
-----------------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function(ev)
    vim.lsp.start({
      name = "pyright",
      cmd = { "pyright-langserver", "--stdio" },
      root_dir = vim.fs.root(ev.buf, { "pyproject.toml", "setup.py", ".git" }) or vim.fn.getcwd(),
      capabilities = capabilities,
    })
  end,
})

-----------------------------------------------------------
-- Start gopls for Go files
-----------------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function(ev)
    vim.lsp.start({
      name = "gopls",
      cmd = { "gopls" },
      root_dir = vim.fs.root(ev.buf, { "go.mod", ".git" }) or vim.fn.getcwd(),
      capabilities = capabilities,
    })
  end,
})

-----------------------------------------------------------
-- LSP keymaps (activated when LSP attaches to buffer)
-----------------------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  end,
})
