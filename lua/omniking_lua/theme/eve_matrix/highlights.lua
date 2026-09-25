local M = {}

local hi = vim.api.nvim_set_hl

local function set_many(groups, value)
    for _, group in ipairs(groups) do
        hi(0, group, value)
    end
end

function M.apply(eve)
    -- ========================================================
    -- EDITOR SURFACES
    -- ========================================================

    hi(0, "Normal", {
        fg = eve.text,
        bg = "NONE",
    })

    hi(0, "NormalNC", {
        fg = eve.text,
        bg = "NONE",
    })

    hi(0, "NormalFloat", {
        fg = eve.text,
        bg = "NONE",
    })

    hi(0, "SignColumn", {
        bg = "NONE",
    })

    hi(0, "FoldColumn", {
        bg = "NONE",
    })

    hi(0, "EndOfBuffer", {
        fg = eve.muted,
        bg = "NONE",
    })

    hi(0, "CursorLine", {
        bg = "NONE",
    })

    hi(0, "LineNr", {
        fg = eve.muted,
    })

    hi(0, "CursorLineNr", {
        fg = eve.accent,
        bold = true,
    })

    hi(0, "WinSeparator", {
        fg = eve.deep_green,
    })

    -- ========================================================
    -- SELECTION / SEARCH
    --
    -- No passive word highlighting.
    -- Background highlighting is reserved for intentional
    -- Visual mode and explicit searching.
    -- ========================================================

    hi(0, "Visual", {
        fg = eve.selection_fg or eve.text_bright,
        bg = eve.selection_bg,
    })

    hi(0, "Search", {
        fg = eve.void,
        bg = eve.bright_lime,
    })

    hi(0, "IncSearch", {
        fg = eve.void,
        bg = eve.electric_green,
        bold = true,
    })

    -- ========================================================
    -- BASE VIM SYNTAX
    -- ========================================================

    hi(0, "Comment", {
        fg = eve.comment,
        italic = true,
    })

    set_many({
        "String",
        "Character",
    }, {
        fg = eve.string,
    })

    set_many({
        "Number",
        "Float",
        "Boolean",
    }, {
        fg = eve.number,
    })

    hi(0, "Identifier", {
        fg = eve.text,
    })

    hi(0, "Function", {
        fg = eve.function_name,
        bold = true,
    })

    set_many({
        "Statement",
        "Repeat",
        "Keyword",
        "Exception",
    }, {
        fg = eve.keyword,
    })

    hi(0, "Conditional", {
        fg = eve.control,
        bold = true,
    })

    set_many({
        "PreProc",
        "Include",
        "Define",
        "PreCondit",
    }, {
        fg = eve.bright_green,
        bold = true,
    })

    hi(0, "Macro", {
        fg = eve.macro,
        bold = true,
    })

    set_many({
        "Type",
        "StorageClass",
        "Structure",
        "Typedef",
    }, {
        fg = eve.type,
    })

    hi(0, "Operator", {
        fg = eve.operator,
    })

    hi(0, "Delimiter", {
        fg = eve.punctuation,
    })

    hi(0, "Special", {
        fg = eve.special,
    })

    -- ========================================================
    -- TREE-SITTER
    -- ========================================================

    hi(0, "@comment", {
        fg = eve.comment,
    })


    italic = true,


    set_many({
        "@string",
        "@character",
    }, {
        fg = eve.string,
    })

    hi(0, "@string.escape", {
        fg = eve.special,
    })

    set_many({
        "@number",
        "@number.float",
        "@boolean",
        "@constant",
        "@constant.macro",
    }, {
        fg = eve.number,
    })

    hi(0, "@constant.builtin", {
        fg = eve.number,
        bold = true,
    })

    hi(0, "@variable", {
        fg = eve.variable,
    })

    hi(0, "@variable.parameter", {
        fg = eve.parameter,
    })

    set_many({
        "@variable.member",
        "@property",
    }, {
        fg = eve.member,
    })

    -- Ordinary functions.
    set_many({
        "@function",
        "@function.call",
    }, {
        fg = eve.function_name,
        bold = true,
    })

    -- Methods intentionally receive a separate related color.
    set_many({
        "@function.method",
        "@function.method.call",
    }, {
        fg = eve.method_name,
        bold = true,
    })

    hi(0, "@function.builtin", {
        fg = eve.function_name,
    })

    -- Macros are deliberately gold so preprocessing constructs
    -- are distinguishable immediately while learning C/C++.
    hi(0, "@function.macro", {
        fg = eve.macro,
        bold = true,
    })

    set_many({
        "@keyword",
        "@keyword.function",
        "@keyword.repeat",
        "@keyword.import",
        "@keyword.directive",
        "@keyword.directive.define",
    }, {
        fg = eve.keyword,
    })

    set_many({
        "@keyword.return",
        "@keyword.conditional",
    }, {
        fg = eve.control,
        bold = true,
    })

    set_many({
        "@type",
        "@type.builtin",
        "@type.definition",
    }, {
        fg = eve.type,
    })

    hi(0, "@operator", {
        fg = eve.operator,
    })

    set_many({
        "@punctuation",
        "@punctuation.bracket",
        "@punctuation.delimiter",
    }, {
        fg = eve.punctuation,
    })

    -- ========================================================
    -- DIAGNOSTICS
    -- ========================================================

    hi(0, "DiagnosticError", {
        fg = "#FF5F6D",
    })

    hi(0, "DiagnosticWarn", {
        fg = eve.gold,
    })

    hi(0, "DiagnosticInfo", {
        fg = eve.cyan_green,
    })

    hi(0, "DiagnosticHint", {
        fg = eve.pale_green,
    })

    -- ========================================================
    -- FLOATS / COMPLETION
    -- ========================================================

    hi(0, "FloatBorder", {
        fg = eve.deep_green,
        bg = "NONE",
    })

    hi(0, "FloatTitle", {
        fg = eve.accent,
        bg = "NONE",
    })

    hi(0, "Pmenu", {
        fg = eve.text,
        bg = "NONE",
    })

    hi(0, "PmenuSel", {
        fg = eve.text_bright,
        bg = eve.selection_bg,
        bold = true,
    })

    -- ========================================================
    -- TELESCOPE
    -- ========================================================

    set_many({
        "TelescopeNormal",
        "TelescopePromptNormal",
        "TelescopeResultsNormal",
        "TelescopePreviewNormal",
    }, {
        fg = eve.text,
        bg = "NONE",
    })

    hi(0, "TelescopeBorder", {
        fg = eve.deep_green,
        bg = "NONE",
    })

    hi(0, "TelescopePromptBorder", {
        fg = eve.electric_green,
        bg = "NONE",
    })

    hi(0, "TelescopeResultsBorder", {
        fg = eve.deep_green,
        bg = "NONE",
    })

    hi(0, "TelescopePreviewBorder", {
        fg = eve.cyan_green,
        bg = "NONE",
    })

    hi(0, "TelescopeSelection", {
        fg = eve.text_bright,
        bg = eve.selection_bg,
        bold = true,
    })

    hi(0, "TelescopeMatching", {
        fg = eve.electric_green,
        bold = true,
    })

    -- ========================================================
    -- STATUS / TAB / WINBAR
    -- ========================================================

    set_many({
        "TabLine",
        "TabLineFill",
        "TabLineSel",
        "StatusLine",
        "StatusLineNC",
        "WinBar",
        "WinBarNC",
    }, {
        fg = eve.text,
        bg = "NONE",
    })
end

return M
