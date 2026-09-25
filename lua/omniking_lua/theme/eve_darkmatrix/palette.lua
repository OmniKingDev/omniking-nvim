local M = {}

local default_theme =
    vim.fn.stdpath("config") .. "/themes/ghostty/EVE-DARKMATRIX"

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
        error("EVE-DARKMATRIX palette not found: " .. path)
    end

    local raw = {
        palette = {},
    }

    for _, original_line in ipairs(vim.fn.readfile(path)) do
        local line = trim(original_line)

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

    assert(raw.background, "EVE-DARKMATRIX is missing background")
    assert(raw.foreground, "EVE-DARKMATRIX is missing foreground")

    for index = 0, 15 do
        assert(
            raw.palette[index],
            "EVE-DARKMATRIX is missing palette index " .. index
        )
    end

    return raw
end

function M.load(path)
    local raw = parse_theme(path or default_theme)
    local ansi = raw.palette

    -- ========================================================
    -- RAW EVE-DARKMATRIX SPECTRUM
    --
    -- Darkmatrix gives us the hierarchy.
    -- EVE gives us the actual colors.
    -- ========================================================

    local eve = {
        raw = raw,

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
        blue_violet = ansi[12],
        bright_magenta = ansi[13],
        cyan = ansi[14],
        white = ansi[15],

        selection_bg = raw.selection_background,
        selection_fg = raw.selection_foreground,
    }

    -- ========================================================
    -- GOLD SPECTRUM
    --
    -- Comments = dim gold.
    -- Macros   = bright gold.
    --
    -- Same family, completely different visual priority.
    -- ========================================================

    eve.gold = "#F2C94C"

    -- ========================================================
    -- VISUAL PRIORITY
    --
    -- Bright:
    --   things that help parse structure quickly.
    --
    -- Medium:
    --   meaningful identifiers/types.
    --
    -- Dim:
    --   supporting information that should not compete.
    -- ========================================================

    eve.text = eve.salmon
    eve.text_bright = eve.lavender

    eve.muted = blend(eve.salmon, eve.void, 0.84)

    -- Comments sink deep into the background while preserving a blue-violet identity.
    eve.comment = blend(eve.blue_violet, eve.void, 0.82)

    -- Strings stay pink-family but sit farther back.
    eve.string = blend(eve.bright_pink, eve.void, 0.72)

    -- Numbers/constants should remain easy to distinguish.
    eve.number = eve.bright_violet

    -- Functions remain one of the strongest landmarks.
    eve.function_name = eve.cyan

    -- Methods stay blue-family, but distinct from functions.
    eve.method_name = blend(eve.cyan, eve.blue_violet, 0.42)

    -- Parameters deliberately recede.
    eve.variable = blend(eve.salmon, eve.void, 0.56)
    eve.parameter = blend(eve.lavender, eve.void, 0.84)

    -- Control-flow should pop immediately.
    eve.keyword = blend(eve.pink, eve.void, 0.40)
    eve.control = eve.bright_rose

    -- Types belong to the purple family.
    eve.type = eve.bright_violet

    -- Members/properties get their own magenta identity.
    eve.member = eve.magenta

    -- Operators visible, but not stronger than functions/control flow.
    eve.operator = eve.bright_pink

    -- Structural punctuation is scaffolding, not content.
    eve.punctuation = blend("#FFD1DF", eve.void, 0.90)

    eve.special = eve.bright_magenta

    -- Macros receive bright gold.
    eve.macro = eve.gold

    eve.accent = eve.cyan

    return eve
end

return M
