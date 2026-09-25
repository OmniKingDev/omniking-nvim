local M = {}

local hi = vim.api.nvim_set_hl

local function set_many(groups, value)
    for _, group in ipairs(groups) do
        hi(0, group, value)
    end
end

function M.apply(eve)
    -- ========================================================
    -- EDITOR SURFACE
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

    hi(0, "LineNr", {
        fg = eve.muted,
        bg = "NONE",
    })

    hi(0, "CursorLineNr", {
        fg = eve.accent,
        bg = "NONE",
        bold = true,
    })

    hi(0, "CursorLine", {
        bg = "NONE",
    })

    hi(0, "WinSeparator", {
        fg = eve.bright_purple,
        bg = "NONE",
    })

    -- ========================================================
    -- SELECTION / SEARCH
    -- ========================================================

    hi(0, "Visual", {
        fg = eve.selection_fg,
        bg = eve.selection_bg,
    })

    hi(0, "Search", {
        fg = eve.background,
        bg = eve.gold,
    })

    hi(0, "IncSearch", {
        fg = eve.background,
        bg = eve.bright_pink,
        bold = true,
    })

    -- ========================================================
    -- COMMENTS
    -- ========================================================

    hi(0, "Comment", {
        fg = eve.comment,
        italic = true,
    })

    hi(0, "@comment", {
        fg = eve.comment,
        italic = true,
    })

    -- Standard NOTE-style captures, when a parser exposes them.
    --
    -- The cross-language NOTE: body treatment can be layered
    -- separately once we test how each parser exposes comments.
    set_many({
        "@comment.note",
        "Todo",
    }, {
        fg = eve.note,
        bold = true,
    })

    -- ========================================================
    -- BASE VIM SYNTAX
    --
    -- Default EVE deliberately groups many concepts together.
    -- The goal is the simple Ghostty-style color hierarchy,
    -- not a different color for every semantic category.
    -- ========================================================

    set_many({
        "Identifier",
        "Function",
    }, {
        fg = eve.text,
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
    })

    set_many({
        "Type",
        "StorageClass",
        "Structure",
        "Typedef",
    }, {
        fg = eve.structure,
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
        "Constant",
    }, {
        fg = eve.number,
    })

    set_many({
        "PreProc",
        "Include",
        "Define",
        "PreCondit",
        "Macro",
    }, {
        fg = eve.bright_magenta,
    })

    hi(0, "Operator", {
        fg = eve.operator,
    })

    hi(0, "Delimiter", {
        fg = eve.text,
    })

    hi(0, "Special", {
        fg = eve.special,
    })

    -- ========================================================
    -- TREE-SITTER
    -- ========================================================

    set_many({
        "@variable",
        "@variable.parameter",
        "@variable.member",
        "@property",

        "@function",
        "@function.call",
        "@function.method",
        "@function.method.call",
        "@function.builtin",
    }, {
        fg = eve.text,
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
        "@keyword.exception",
    }, {
        fg = eve.control,
    })

    set_many({
        "@type",
        "@type.builtin",
        "@type.definition",

        "@module",
        "@namespace",
    }, {
        fg = eve.structure,
    })

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
        "@constant.builtin",
    }, {
        fg = eve.number,
    })

    set_many({
        "@constant.macro",
        "@function.macro",
    }, {
        fg = eve.bright_magenta,
    })

    hi(0, "@operator", {
        fg = eve.operator,
    })

    set_many({
        "@punctuation",
        "@punctuation.bracket",
        "@punctuation.delimiter",
    }, {
        fg = eve.text,
    })

    -- ========================================================
    -- LSP SEMANTIC TOKENS
    --
    -- Keep semantic tokens from turning default EVE back into
    -- a highly segmented theme.
    -- ========================================================

    set_many({
        "@lsp.type.variable",
        "@lsp.type.parameter",
        "@lsp.type.property",
        "@lsp.type.function",
        "@lsp.type.method",
    }, {
        fg = eve.text,
    })

    set_many({
        "@lsp.type.namespace",
        "@lsp.type.class",
        "@lsp.type.struct",
        "@lsp.type.interface",
        "@lsp.type.type",
        "@lsp.type.typeParameter",
    }, {
        fg = eve.structure,
    })

    set_many({
        "@lsp.type.enumMember",
        "@lsp.type.number",
    }, {
        fg = eve.number,
    })

    -- ========================================================
    -- DIAGNOSTICS
    -- ========================================================

    hi(0, "DiagnosticError", {
        fg = eve.rose,
    })

    hi(0, "DiagnosticWarn", {
        fg = eve.gold,
    })

    hi(0, "DiagnosticInfo", {
        fg = eve.cyan,
    })

    hi(0, "DiagnosticHint", {
        fg = eve.lavender,
    })

    -- ========================================================
    -- COMPLETION / FLOATS
    -- ========================================================

    hi(0, "FloatBorder", {
        fg = eve.bright_purple,
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
        fg = eve.selection_fg,
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
        fg = eve.bright_purple,
        bg = "NONE",
    })

    hi(0, "TelescopePromptBorder", {
        fg = eve.pink,
        bg = "NONE",
    })

    hi(0, "TelescopeResultsBorder", {
        fg = eve.bright_purple,
        bg = "NONE",
    })

    hi(0, "TelescopePreviewBorder", {
        fg = eve.cyan,
        bg = "NONE",
    })

    hi(0, "TelescopeSelection", {
        fg = eve.selection_fg,
        bg = eve.selection_bg,
        bold = true,
    })

    hi(0, "TelescopeMatching", {
        fg = eve.bright_pink,
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
