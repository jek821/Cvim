-----------------------------------------------------------
-- DAP (Debug Adapter Protocol) Configuration
-----------------------------------------------------------

local dap = require("dap")
local dapui = require("dapui")

-----------------------------------------------------------
-- DAP UI Setup
-----------------------------------------------------------
dapui.setup({
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.25 },
        { id = "breakpoints", size = 0.25 },
        { id = "stacks", size = 0.25 },
        { id = "watches", size = 0.25 },
      },
      size = 40,
      position = "left",
    },
    {
      elements = {
        { id = "repl", size = 0.5 },
        { id = "console", size = 0.5 },
      },
      size = 10,
      position = "bottom",
    },
  },
})

-----------------------------------------------------------
-- Auto-open/close DAP UI
-----------------------------------------------------------
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-----------------------------------------------------------
-- GDB Adapter Configuration
-----------------------------------------------------------
dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "-i", "dap" }
}

-----------------------------------------------------------
-- C/C++ Debug Configuration
-----------------------------------------------------------
dap.configurations.c = {
  {
    name = "Launch",
    type = "gdb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
  },
}

-- Copy C config to C++
dap.configurations.cpp = dap.configurations.c
