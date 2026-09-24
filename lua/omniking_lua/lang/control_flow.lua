local M = {}

local highlight_group = "OmniControlFlow"
local augroup_name = "OmniControlFlowBehavior"

local function is_supported_filetype()
    return vim.bo.filetype == "c" or vim.bo.filetype == "cpp"
end

local function define_highlight()
    -- The behavior owns WHAT exit() represents.
    -- The active colorscheme owns HOW control flow looks.
    --
    -- Linking here keeps this feature independent from EVE-PRIME.
    vim.api.nvim_set_hl(0, highlight_group, {
        link = "@keyword.return",
    })
end

function M.apply()
    if not is_supported_filetype() then
        return
    end

    define_highlight()

    -- matchadd() is window-local, so remove the old match before
    -- adding a fresh one whenever this window becomes active again.
    if vim.w.omni_control_flow_match then
        pcall(vim.fn.matchdelete, vim.w.omni_control_flow_match)
        vim.w.omni_control_flow_match = nil
    end

    vim.w.omni_control_flow_match = vim.fn.matchadd(
        highlight_group,
        [[\<\(_exit\|exit\)\ze\s*(]],
        200
    )
end

function M.setup()
    -- setup() may be reached from both c.lua and cpp.lua.
    -- Register the shared autocmds only once.
    if not vim.g.omni_control_flow_initialized then
        vim.g.omni_control_flow_initialized = true

        local group = vim.api.nvim_create_augroup(
            augroup_name,
            { clear = true }
        )

        vim.api.nvim_create_autocmd(
            { "BufWinEnter", "ColorScheme" },
            {
                group = group,
                callback = function()
                    vim.schedule(M.apply)
                end,
            }
        )
    end

    M.apply()
end

return M
