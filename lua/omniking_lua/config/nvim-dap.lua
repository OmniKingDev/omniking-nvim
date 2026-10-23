local M = {}

local function make_gdb_config(dap)
  return {
    {
      name = "Launch Executable (Stop at main)",
      type = "gdb",
      request = "launch",
      program = function()
        local path = vim.fn.input(
          "Path to executable: ",
          vim.fn.getcwd() .. "/",
          "file"
        )

        if path == "" then return dap.ABORT end

        return vim.fn.fnamemodify(path, ":p")
      end,
      cwd = "${workspaceFolder}",
      args = {},
      stopAtBeginningOfMainSubprogram = true,
    },
  }
end

function M.setup()
  local dap = require("dap")

  -- GDB's native Debug Adapter Protocol (DAP), not GDB/MI.
  dap.adapters.gdb = {
    type = "executable",
    command = "gdb",
    args = {
      "--interpreter=dap",
      "--eval-command",
      "set print pretty on",
    },
  }

  dap.defaults.fallback.stepping_granularity = "line"

  -- Modify the active table in place. Do not replace dap.configurations:
  -- replacing it discards configurations already registered elsewhere.
  local configurations = dap.configurations
  local mt = getmetatable(configurations)

  if mt == nil then
    mt = {}
  elseif type(mt) ~= "table" then
    error("nvim-dap configurations has a protected metatable; cannot add wildcard")
  end

  if mt.__nvim_dap_gdb_wildcard then return end

  local previous_index = mt.__index

  mt.__index = function(tbl, filetype)
    local existing

    if type(previous_index) == "function" then
      existing = previous_index(tbl, filetype)
    elseif type(previous_index) == "table" then
      existing = previous_index[filetype]
    end

    if existing ~= nil then return existing end

    -- Materialize a config list for each previously unconfigured filetype.
    local fallback = make_gdb_config(dap)
    rawset(tbl, filetype, fallback)
    return fallback
  end

  mt.__nvim_dap_gdb_wildcard = true
  setmetatable(configurations, mt)
end

return M
