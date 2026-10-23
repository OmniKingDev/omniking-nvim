-- ~/.config/nvim/after/plugin/splitasm.lua

-- SplitAsm assembly-row colors
vim.api.nvim_set_hl(0, "SplitAsm", { link = "Search" })

local group = vim.api.nvim_create_augroup(
    "SplitAsmCursorline",
    { clear = true }
)

local active_session = nil

-- Cursorline is reserved for active SplitAsm sessions.
for _, win in ipairs(vim.api.nvim_list_wins()) do
    vim.wo[win].cursorline = false
end

local function open_splitasm()
    -- Open SplitAsm from the current source window.
    local ok, err = pcall(vim.cmd, "SplitAsm")

    if not ok then
        vim.notify(
            "SplitAsm failed: " .. tostring(err),
            vim.log.levels.ERROR
        )
        return
    end

    -- Read SplitAsm's own window state after it opens.
    local state_ok, state_module = pcall(require, "splitasm.state")

    if not state_ok then
        return
    end

    local state = state_module.get()
    local source_win = state.source_win
    local asm_win = state.asm_win

    if not source_win or not vim.api.nvim_win_is_valid(source_win)
        or not asm_win or not vim.api.nvim_win_is_valid(asm_win) then
        return
    end

    -- Preserve the original cursorlineopt when refreshing/reopening.
    local previous_cursorlineopt

    if active_session
        and active_session.source_win == source_win
        and active_session.asm_win == asm_win then
        previous_cursorlineopt = active_session.cursorlineopt
    else
        previous_cursorlineopt = vim.wo[source_win].cursorlineopt
    end

    active_session = {
        source_win = source_win,
        asm_win = asm_win,
        cursorlineopt = previous_cursorlineopt,
    }

    -- Highlight the active source line and its line number.
    vim.wo[source_win].cursorline = true
    vim.wo[source_win].cursorlineopt = "line,number"
end

-- Disable the highlight when the assembly split closes.
vim.api.nvim_create_autocmd("WinClosed", {
    group = group,

    callback = function(args)
        if not active_session then
            return
        end

        local closed_win = tonumber(args.match)

        if closed_win == active_session.asm_win then
            local source_win = active_session.source_win

            if vim.api.nvim_win_is_valid(source_win) then
                vim.wo[source_win].cursorline = false
                vim.wo[source_win].cursorlineopt =
                    active_session.cursorlineopt
            end

            active_session = nil

        elseif closed_win == active_session.source_win then
            active_session = nil
        end
    end,
})

-- Open SplitAsm with automatic source-line highlighting.
vim.keymap.set("n", "<leader><leader>a", open_splitasm, {
    desc = "Open SplitAsm with source-line highlighting",
})
