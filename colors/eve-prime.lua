vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
end

vim.o.termguicolors = true
vim.g.colors_name = "eve-prime"

local hi = vim.api.nvim_set_hl

-- EVE-PRIME / old Neovim palette
local fg          = "#8DBCB5"
local bright_fg   = "#AAEFC4"
local pink        = "#FF2FD6"
local purple      = "#892AE6"
local violet      = "#C401F8"
local cyan        = "#02CFF8"
local mint        = "#39FFD1"
local electric    = "#00FFC4"
local string      = "#CC849C"
local comment     = "#6E457D"
local control     = "#FF4057" -- alternate: "#00D7B5"
vim.g.eve_control_color = control

-- Transparent editor
hi(0, "Normal",      { fg = fg, bg = "NONE" })
hi(0, "NormalNC",    { fg = fg, bg = "NONE" })
hi(0, "SignColumn",  { bg = "NONE" })
hi(0, "EndOfBuffer", { fg = "#2B878D", bg = "NONE" })

-- Base Vim syntax
hi(0, "Comment",      { fg = comment, italic = true })

hi(0, "String",       { fg = string })
hi(0, "Character",    { fg = string })

hi(0, "Number",       { fg = violet })
hi(0, "Float",        { fg = violet })
hi(0, "Boolean",      { fg = violet })

hi(0, "Identifier",   { fg = fg })
hi(0, "Function",     { fg = cyan, bold = true })

hi(0, "Statement",    { fg = pink })
hi(0, "Conditional",  { fg = control, bold = true })
hi(0, "Repeat",       { fg = pink })
hi(0, "Keyword",      { fg = pink })
hi(0, "Exception",    { fg = pink })

hi(0, "PreProc",      { fg = pink })
hi(0, "Include",      { fg = pink })
hi(0, "Define",       { fg = pink })
hi(0, "Macro",        { fg = pink })
hi(0, "PreCondit",    { fg = pink })

hi(0, "Type",         { fg = purple })
hi(0, "StorageClass", { fg = purple })
hi(0, "Structure",    { fg = purple })
hi(0, "Typedef",      { fg = purple })

hi(0, "Operator",     { fg = mint })
hi(0, "Delimiter",    { fg = mint })
hi(0, "Special",      { fg = electric })

-- Tree-sitter
hi(0, "@comment",                 { fg = comment, italic = true })

hi(0, "@string",                  { fg = string })
hi(0, "@string.escape",           { fg = mint })
hi(0, "@character",               { fg = string })

hi(0, "@number",                  { fg = violet })
hi(0, "@number.float",            { fg = violet })
hi(0, "@boolean",                 { fg = violet })

hi(0, "@variable",                { fg = fg })
hi(0, "@variable.parameter",      { fg = bright_fg })
hi(0, "@variable.member",         { fg = electric })
hi(0, "@property",                { fg = electric })

hi(0, "@constant",                { fg = violet })
hi(0, "@constant.builtin",        { fg = violet, bold = true })
hi(0, "@constant.macro",          { fg = violet })

hi(0, "@function",                { fg = cyan, bold = true })
hi(0, "@function.call",           { fg = cyan, bold = true })
hi(0, "@function.method",         { fg = cyan, bold = true })
hi(0, "@function.method.call",    { fg = cyan, bold = true })
hi(0, "@function.builtin",        { fg = cyan })
hi(0, "@function.macro",          { fg = cyan })

hi(0, "@keyword",                 { fg = pink })
hi(0, "@keyword.function",        { fg = pink })
hi(0, "@keyword.return",          { fg = control, bold = true })
hi(0, "@keyword.conditional",     { fg = control, bold = true })
hi(0, "@keyword.repeat",          { fg = pink })
hi(0, "@keyword.import",          { fg = pink })
hi(0, "@keyword.directive",       { fg = pink })
hi(0, "@keyword.directive.define",{ fg = pink })

hi(0, "@type",                    { fg = purple })
hi(0, "@type.builtin",            { fg = purple })
hi(0, "@type.definition",         { fg = purple })

hi(0, "@operator",                { fg = mint })
hi(0, "@punctuation",             { fg = mint })
hi(0, "@punctuation.bracket",     { fg = mint })
hi(0, "@punctuation.delimiter",   { fg = mint })

-- Editor UI
hi(0, "LineNr",       { fg = "#5D8B82" })
hi(0, "CursorLineNr", { fg = mint, bold = true })
hi(0, "WinSeparator", { fg = mint })
hi(0, "Visual",       { fg = "#101410", bg = "#00FFC4", bold = true, blend = 0 })

hi(0, "Search",       { fg = "#101410", bg = mint })
hi(0, "IncSearch",    { fg = "#101410", bg = pink })

hi(0, "DiagnosticError", { fg = "#FF5F6D" })
hi(0, "DiagnosticWarn",  { fg = "#D6A94A" })
hi(0, "DiagnosticInfo",  { fg = cyan })
hi(0, "DiagnosticHint",  { fg = mint })

-- ============================================================
-- EVE-PRIME FINAL UI
-- ============================================================

local eve_hi = vim.api.nvim_set_hl

local eve_fg            = "#8DBCB5"
local eve_bright_fg     = "#AAEFC4"
local eve_jade          = "#39FFD1"
local eve_comment       = "#6E457D"
local eve_pink          = "#FF2FD6"
local eve_purple        = "#892AE6"
local eve_electric      = "#00FFC4"
local eve_visual_purple = "#442A52"

-- Editor surfaces
eve_hi(0, "Normal",       { fg = eve_fg, bg = "NONE" })
eve_hi(0, "NormalNC",     { fg = eve_fg, bg = "NONE" })
eve_hi(0, "NormalFloat",  { fg = eve_fg, bg = "NONE" })
eve_hi(0, "FloatBorder",  { fg = eve_purple, bg = "NONE" })
eve_hi(0, "FloatTitle",   { fg = eve_jade, bg = "NONE" })
eve_hi(0, "SignColumn",   { bg = "NONE" })
eve_hi(0, "FoldColumn",   { bg = "NONE" })
eve_hi(0, "CursorLine",   { bg = "NONE" })
eve_hi(0, "CursorLineNr", { fg = eve_jade, bold = true })

-- Selection
eve_hi(0, "Visual", {
    fg = eve_fg,
    bg = eve_visual_purple,
    bold = false,
})

-- Completion menu
eve_hi(0, "Pmenu", {
    fg = eve_fg,
    bg = "NONE",
})

eve_hi(0, "PmenuSel", {
    fg = eve_bright_fg,
    bg = eve_visual_purple,
    bold = true,
})

-- Telescope
eve_hi(0, "TelescopeNormal", {
    fg = eve_fg,
    bg = "NONE",
})

eve_hi(0, "TelescopeBorder", {
    fg = eve_purple,
    bg = "NONE",
})

eve_hi(0, "TelescopePromptNormal", {
    fg = eve_fg,
    bg = "NONE",
})

eve_hi(0, "TelescopePromptBorder", {
    fg = eve_pink,
    bg = "NONE",
})

eve_hi(0, "TelescopeResultsNormal", {
    fg = eve_fg,
    bg = "NONE",
})

eve_hi(0, "TelescopeResultsBorder", {
    fg = eve_purple,
    bg = "NONE",
})

eve_hi(0, "TelescopePreviewNormal", {
    fg = eve_fg,
    bg = "NONE",
})

eve_hi(0, "TelescopePreviewBorder", {
    fg = eve_jade,
    bg = "NONE",
})

eve_hi(0, "TelescopeSelection", {
    fg = eve_bright_fg,
    bg = eve_visual_purple,
    bold = true,
})

eve_hi(0, "TelescopeMatching", {
    fg = eve_pink,
    bold = true,
})

-- Tabs/status surfaces remain transparent if added later
for _, group in ipairs({
    "TabLine",
    "TabLineFill",
    "TabLineSel",
    "StatusLine",
    "StatusLineNC",
    "WinBar",
    "WinBarNC",
}) do
    eve_hi(0, group, { fg = eve_fg, bg = "NONE" })
end

-- Final EVE syntax overrides
eve_hi(0, "Delimiter",              { fg = eve_jade, bold = true })
eve_hi(0, "@punctuation",           { fg = eve_jade, bold = true })
eve_hi(0, "@punctuation.delimiter", { fg = eve_jade, bold = true })
eve_hi(0, "@punctuation.bracket",   { fg = eve_jade, bold = true })

eve_hi(0, "Comment",      { fg = eve_comment, italic = true })
eve_hi(0, "@comment",     { fg = eve_comment, italic = true })
eve_hi(0, "@comment.c",   { fg = eve_comment, italic = true })
eve_hi(0, "@comment.lua", { fg = eve_comment, italic = true })

eve_hi(0, "PreProc",    { fg = eve_pink, bold = true })
eve_hi(0, "Include",    { fg = eve_pink, bold = true })
eve_hi(0, "Define",     { fg = eve_pink, bold = true })
eve_hi(0, "Macro",      { fg = eve_pink, bold = true })
eve_hi(0, "PreCondit",  { fg = eve_pink, bold = true })

eve_hi(0, "@variable.member",   { fg = eve_electric })
eve_hi(0, "@variable.member.c", { fg = eve_electric })
eve_hi(0, "@property",          { fg = eve_electric })
eve_hi(0, "@property.c",        { fg = eve_electric })

-- Color exit()/ _exit() like EVE control-flow keywords in C/C++.
local function eve_control_flow()
    if vim.g.colors_name ~= "eve-prime" then
        if vim.w.eve_exit_match then
            pcall(vim.fn.matchdelete, vim.w.eve_exit_match)
            vim.w.eve_exit_match = nil
        end
        return
    end

    eve_hi(0, "EveControlFlow", {
        fg = vim.g.eve_control_color or "#FF4057",
        bold = true,
    })

    if vim.bo.filetype ~= "c" and vim.bo.filetype ~= "cpp" then
        return
    end

    if vim.w.eve_exit_match then
        pcall(vim.fn.matchdelete, vim.w.eve_exit_match)
    end

    vim.w.eve_exit_match = vim.fn.matchadd(
        "EveControlFlow",
        [[\<\(_exit\|exit\)\ze\s*(]],
        200
    )
end

local eve_group =
    vim.api.nvim_create_augroup("EvePrimeControlFlow", { clear = true })

vim.api.nvim_create_autocmd(
    { "FileType", "BufWinEnter", "ColorScheme" },
    {
        group = eve_group,
        callback = function()
            vim.schedule(eve_control_flow)
        end,
    }
)

vim.schedule(eve_control_flow)
