-- Point to an isolated cache file for instant disk persistence
local theme_cache = vim.fn.stdpath("state") .. "/global_theme.txt"
local fallback = "rose-pine-moon"

-- NEW: Helper function to strip background elements so your Ghostty terminal shows through
local function clear_background()
    -- 1. Core Editor Backgrounds
    local transparent_groups = { 
        "Normal", "NormalFloat", "NormalNC", "SignColumn", "StatusLine",
        "LineNr", "CursorLineNr", "FoldColumn", "CursorLine"
    }
    for _, group in ipairs(transparent_groups) do
        vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
    end

    -- 2. File Explorer (Netrw)
    vim.api.nvim_set_hl(0, "netrwDir", { bg = "none" })
    vim.api.nvim_set_hl(0, "netrwClassify", { bg = "none" })

    -- 3. FIX: Debugging (DAP), Diagnostics, & Git Signs (Left-Side Letters/Gutter)
    local diagnostic_and_debug = {
        "DiagnosticSignError", "DiagnosticSignWarn", "DiagnosticSignInfo", "DiagnosticSignHint",
        "DapBreakpoint", "DapBreakpointCondition", "DapLogPoint", "DapStopped",
        "GitSignsAdd", "GitSignsChange", "GitSignsDelete"
    }
    for _, group in ipairs(diagnostic_and_debug) do
        local current = vim.api.nvim_get_hl(0, { name = group })
        current.bg = "none"
        vim.api.nvim_set_hl(0, group, current)
    end

    -- 4. FIX: Plugin Windows, Borders, Floating Displays, & Menus
    -- This strips solid backgrounds behind borders for Telescope, Blink-cmp, Lazy, Mason, etc.
    local UI_elements = {
        -- Floating menus and popups
        "FloatBorder", "NormalFloat", "Pmenu", "PmenuSel", "PmenuSbar", "PmenuThumb",
        -- Telescope specific borders
        "TelescopeBorder", "TelescopeNormal", "TelescopePromptBorder", "TelescopeResultsBorder", "TelescopePreviewBorder",
        -- Snacks / UI Popups
        "SnacksNormal", "SnacksBorder",
        -- General Borders used by LSP hover doc files and diagnostics
        "BlinkCmpMenu", "BlinkCmpMenuBorder", "BlinkCmpDoc", "BlinkCmpDocBorder"
    }
    for _, group in ipairs(UI_elements) do
        local current = vim.api.nvim_get_hl(0, { name = group })
        current.bg = "none"
        vim.api.nvim_set_hl(0, group, current)
    end
end

-- 1. READ/WRITE: Low-level file engine
local function read_saved_theme()
    local f = io.open(theme_cache, "r")
    if not f then return fallback end
    local val = f:read("*l") f:close()
    return (val and val:match("^%s*(.-)%s*$") ~= "") and val or fallback
end

local function save_global_theme(name)
    local f = io.open(theme_cache, "w")
    if f then
        f:write(name)
        f:close()
    end
end

-- 2. LIVE SYNC ENGINE: Keeps all separate terminal instances updated live
local function start_global_listener()
    local timer = vim.loop.new_timer()
    local last_seen_theme = read_saved_theme()

    -- Instantly apply the initial state on startup
    -- if pcall(vim.cmd, "colorscheme " .. last_seen_theme) then
    --     clear_background()
    -- end
    pcall(vim.cmd, "colorscheme " .. last_seen_theme)

    -- Poll the disk file every 500ms to see if another terminal window changed it
    timer:start(0, 500, vim.schedule_wrap(function()
        local current_disk_theme = read_saved_theme()
        if current_disk_theme ~= last_seen_theme then
            last_seen_theme = current_disk_theme
            pcall(vim.cmd, "colorscheme " .. current_disk_theme)
        end
    end))
end

-- 3. THE COMMAND & TAB COMPLETION (Option 1 Integration)
vim.api.nvim_create_user_command(
    'Colors',
    function(opts)
        local choice = opts.args
        if choice == nil or choice == '' then vim.cmd('colorscheme') return end

        local available = vim.fn.getcompletion('', 'color')

        if vim.tbl_contains(available, choice) then
            save_global_theme(choice) -- This triggers the live updates everywhere
            vim.cmd('colorscheme ' .. choice)
        else
            print("Error: Colorscheme '" .. choice .. "' is not installed.")
        end
    end,
    {
        nargs = '?',
        complete = 'color', -- Pulls all lazy.nvim themes cleanly on <Tab>
    }
)

-- Kick off the synchronization engine
start_global_listener()
