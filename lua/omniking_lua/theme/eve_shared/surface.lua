local M = {}

local groups = {
    "Normal",
    "NormalNC",
    "NormalFloat",

    "SignColumn",
    "FoldColumn",
    "EndOfBuffer",
    "LineNr",
    "CursorLineNr",
    "CursorLine",
    "WinSeparator",

    "Pmenu",

    "FloatBorder",
    "FloatTitle",

    "TelescopeNormal",
    "TelescopePromptNormal",
    "TelescopeResultsNormal",
    "TelescopePreviewNormal",

    "TelescopeBorder",
    "TelescopePromptBorder",
    "TelescopeResultsBorder",
    "TelescopePreviewBorder",

    "TabLine",
    "TabLineFill",
    "TabLineSel",

    "StatusLine",
    "StatusLineNC",
    "WinBar",
    "WinBarNC",
}

function M.apply(eve, opts)
    local background =
        eve.background
        or eve.void
        or (eve.raw and eve.raw.background)

    assert(background, "EVE variant does not provide a background")

    local surface = background

    if opts.use_terminal_background then
        surface = "NONE"
    end

    for _, group in ipairs(groups) do
        local hl = vim.api.nvim_get_hl(0, {
            name = group,
            link = false,
        })

        hl.bg = surface
        vim.api.nvim_set_hl(0, group, hl)
    end
end

return M
