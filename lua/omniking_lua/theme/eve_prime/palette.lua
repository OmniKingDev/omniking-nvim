local M = {}

-- ============================================================
-- EVE-PRIME PALETTE
--
-- PRIME is the richer rose/plum variation of the EVE family.
--
-- Raw terminal color ownership:
--   themes/ghostty/EVE-PRIME
--
-- This module translates that raw terminal palette into semantic
-- Neovim roles. It does NOT define editor highlights itself.
-- ============================================================

local prime_theme =
    vim.fn.stdpath("config") .. "/themes/ghostty/EVE-PRIME"


local function blend(a, b, amount)
    local function channel(color, offset)
        return tonumber(color:sub(offset, offset + 1), 16)
    end

    local function mix(x, y)
        return math.floor(x + (y - x) * amount + 0.5)
    end

    return string.format(
        "#%02X%02X%02X",
        mix(channel(a, 2), channel(b, 2)),
        mix(channel(a, 4), channel(b, 4)),
        mix(channel(a, 6), channel(b, 6))
    )
end


local function trim(value)
    return value:match("^%s*(.-)%s*$")
end


local function parse_theme(path)
    if vim.fn.filereadable(path) ~= 1 then
        error("EVE-PRIME palette not found: " .. path)
    end

    local raw = {
        palette = {},
    }

    for _, original_line in ipairs(vim.fn.readfile(path)) do
        local line = trim(original_line)

        -- Ghostty comments begin with '#'.
        -- Hex colors also begin with '#', so only skip when the
        -- FIRST non-whitespace character is '#'.
        if line ~= "" and line:sub(1, 1) ~= "#" then
            local key, value =
                line:match("^([%w%-]+)%s*=%s*(.-)%s*$")

            if key and value then
                if key == "palette" then
                    local index, color =
                        value:match("^(%d+)%s*=%s*(#%x%x%x%x%x%x)$")

                    if index and color then
                        raw.palette[tonumber(index)] = color:upper()
                    end

                elseif key == "background" then
                    raw.background = value:upper()

                elseif key == "foreground" then
                    raw.foreground = value:upper()

                elseif key == "selection-background" then
                    raw.selection_background = value:upper()

                elseif key == "selection-foreground" then
                    raw.selection_foreground = value:upper()
                end
            end
        end
    end

    assert(raw.background, "EVE-PRIME is missing background")
    assert(raw.foreground, "EVE-PRIME is missing foreground")

    for index = 0, 15 do
        assert(
            raw.palette[index],
            "EVE-PRIME is missing palette index " .. index
        )
    end

    return raw
end


function M.load(path)
    local raw = parse_theme(path or prime_theme)
    local ansi = raw.palette

    -- ========================================================
    -- RAW EVE-PRIME IDENTITY
    --
    -- These names describe the actual colors rather than the
    -- conventional ANSI meaning of their numbered slots.
    -- ========================================================

    local eve = {
        raw = raw,

        background = raw.background,
        foreground = raw.foreground,

        void = raw.background,
        salmon = raw.foreground,

        deep_purple = ansi[0],
        rose = ansi[1],
        violet = ansi[2],
        pink = ansi[3],
        electric_purple = ansi[4],
        magenta = ansi[5],
        ultraviolet = ansi[6],
        lavender = ansi[7],

        plum = ansi[8],
        bright_rose = ansi[9],
        bright_violet = ansi[10],
        bright_pink = ansi[11],
        bright_purple = ansi[12],
        bright_magenta = ansi[13],
        cyan = ansi[14],
        white = ansi[15],

        selection_bg = raw.selection_background,
        selection_fg = raw.selection_foreground,
    }


    -- ========================================================
    -- EVE-PRIME SEMANTIC SPECTRUM
    --
    -- PRIME is intentionally richer and more segmented than
    -- canonical EVE.
    --
    -- Canonical EVE:
    --     simple terminal-inspired hierarchy
    --
    -- EVE-PRIME:
    --     richer semantic separation using the same family
    --
    -- EVE-DARKMATRIX:
    --     darker, higher-contrast hierarchy
    -- ========================================================

    eve.text = eve.salmon
    eve.text_bright = eve.lavender
    eve.muted = eve.plum


    -- Dusty lavender comments sit apart from champagne-gold types.
    eve.comment = eve.bright_purple

    -- Namespaces use a clearer lavender from the same family.
    eve.namespace = eve.bright_violet


    -- Strings use a chosen dusty rose rather than a darkened pink.
    eve.string = eve.bright_pink
    eve.number = eve.bright_violet


    -- Parameters keep a soft lavender identity alongside salmon text.
    eve.parameter =
        blend(eve.lavender, eve.void, 0.28)


    -- Richer cyan for function names; methods retain their softer shade.
    eve.function_name = "#64D5DA"
    eve.method_name =
        blend(eve.cyan, eve.void, 0.14)


    -- Champagne gold separates types from the rose/plum syntax family.
    -- Macros use a lighter shade of that same accent.
    eve.gold = "#DEC18C"
    eve.gold_dim =
        blend(eve.gold, eve.void, 0.50)
    -- Types get a richer gold while macros retain the champagne shade.
    eve.type = "#E8BF68"
    eve.macro = blend(eve.gold, eve.white, 0.20)


    -- Saturated rose gives keywords a stronger accent.
    eve.keyword = "#EF89B8"
    eve.control = eve.bright_rose

    eve.member = eve.magenta
    eve.operator = eve.pink


    -- Punctuation follows the lavender neutrals with gentle emphasis.
    eve.punctuation =
        blend(eve.lavender, eve.void, 0.38)

    eve.special = eve.bright_magenta


    eve.accent = eve.cyan


    return eve
end


return M
