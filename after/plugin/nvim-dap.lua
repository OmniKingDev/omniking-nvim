local dap = require("dap")
local dapui = require("dapui")

-- Keep x86-64 GDB register expressions visible in the Watches panel.
-- These apply to the native x86-64 Linux development target.
local register_expressions = {
  "$rip",
  "$rsp",
  "$rbp",
  "$rax",
  "$rbx",
  "$rcx",
  "$rdx",
  "$rsi",
  "$rdi",
  "$r8",
  "$r9",
  "$r10",
  "$r11",
  "$r12",
  "$r13",
  "$r14",
  "$r15",
  "$eflags",
}

local already_watched = {}
for _, watch in ipairs(dapui.elements.watches.get()) do already_watched[watch.expression] = true end

for _, expression in ipairs(register_expressions) do
  if not already_watched[expression] then
    dapui.elements.watches.add(expression)
    already_watched[expression] = true
  end
end

-- Start GDB's native process recording on the first stop. On x86-64 Linux,
-- GDB's record-full target supports reverse execution. Recording starts at
-- this stop; it cannot reconstruct execution that happened before the stop.
local recording_started = {}

dap.listeners.after.event_stopped["nvim_dap_gdb_record"] = function(session)
  if session.config.type ~= "gdb" or session.config.request ~= "launch" then
    return
  end

  if recording_started[session.id] then
    return
  end

  recording_started[session.id] = true
  vim.schedule(function()
    -- Only send the command to the session that generated the stop event.
    if dap.session() == session then
      dap.repl.execute("record full")
    end
  end)
end

local function clear_recording_state(session)
  if session then
    recording_started[session.id] = nil
  end
end

dap.listeners.after.event_terminated["nvim_dap_gdb_record"] = clear_recording_state
dap.listeners.after.event_exited["nvim_dap_gdb_record"] = clear_recording_state

-- UI lifecycle.
dap.listeners.before.attach["nvim_dap_ui"] = function() dapui.open() end

dap.listeners.before.launch["nvim_dap_ui"] = function() dapui.open() end

dap.listeners.before.event_terminated["nvim_dap_ui"] = function() dapui.close() end

dap.listeners.before.event_exited["nvim_dap_ui"] = function() dapui.close() end

-- Single-press stepping controls.
vim.keymap.set("n", "<Down>", dap.step_over, { desc = "Debugger: Step Over", })

vim.keymap.set("n", "<Right>", dap.step_into, { desc = "Debugger: Step Into", })

vim.keymap.set("n", "<Left>", dap.step_out, { desc = "Debugger: Step Out", })

-- Use GDB's CLI reverse-step via the DAP REPL. This avoids calling the
-- separate DAP restartFrame request, which GDB's adapter may not support.
vim.keymap.set("n", "<Up>", function()
  local session = dap.session()

  if not session then
    vim.notify("Debugger: no active session", vim.log.levels.WARN)
    return
  end

  if session.config.type ~= "gdb" then
    vim.notify("Debugger: reverse-step mapping requires a GDB session", vim.log.levels.WARN)
    return
  end

  if not recording_started[session.id] then
    recording_started[session.id] = true
    dap.repl.execute("record full")
    vim.notify(
      "GDB recording started. Step forward before attempting reverse-step.",
      vim.log.levels.INFO
    )
    return
  end

  dap.repl.execute("reverse-step")
end, { desc = "Debugger: Reverse Step (GDB record full)" })

vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debugger: Start / Continue", })

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debugger: Toggle Breakpoint", })

vim.keymap.set("n", "<leader>dx", dap.terminate, { desc = "Debugger: Terminate Session", })

vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debugger: Toggle UI Windows", })

vim.keymap.set("n", "<leader>dr", vim.cmd.DapToggleRepl, { desc = "Debugger: Open REPL", })

