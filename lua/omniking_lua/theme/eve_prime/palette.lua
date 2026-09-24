local M = {}

-- This is the palette file shared with Ghostty.
-- Neovim reads the same source rather than maintaining another copy
-- of EVE-PRIME's hexadecimal colors.
local default_theme =
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
        -- Hex colors also begin with '#', so only skip the line when
        -- the FIRST non-whitespace character is '#'.
        if line ~= "" and line:sub(1, 1) ~= "#" then
            local key, value = line:match("^([%w%-]+)%s*=%s*(.-)%s*$")

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
    local raw = parse_theme(path or default_theme)
    local ansi = raw.palette

    -- --------------------------------------------------------
    -- Raw EVE identity
    --
    -- These names describe what the colors actually LOOK like.
    -- We deliberately do NOT treat Ghostty's ANSI slot names as
    -- syntax semantics. ANSI slot 2 does not automatically mean
    -- "Neovim green", for example.
    -- --------------------------------------------------------

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
        bright_purple = ansi[12],
        bright_magenta = ansi[13],
        cyan = ansi[14],
        white = ansi[15],

        selection_bg = raw.selection_background,
        selection_fg = raw.selection_foreground,
    }

    -- --------------------------------------------------------
    -- Neovim semantic roles
    --
    -- THIS is the layer we will tune visually.
    -- Ghostty owns the raw colors above.
    -- Neovim decides what those colors mean below.
    -- --------------------------------------------------------

    eve.text = eve.salmon
    eve.text_bright = eve.lavender
    eve.muted = eve.plum

    eve.comment = eve.bright_purple
    -- Namespaces stay in the comment-purple family, but brighter.
    -- This makes qualifiers such as `std` easy to parse without
    -- giving them a completely separate visual identity.
    eve.namespace = blend(eve.comment, eve.lavender, 0.28)
    -- Strings should remain readable without competing with code structure.
    -- Start from EVE pink, then pull it heavily toward the void.
    eve.string = blend(eve.pink, eve.void, 0.48)
    eve.number = eve.bright_violet

    -- ============================================================
    -- EVE SEMANTIC SPECTRUM
    --
    -- Bright roles identify important structure quickly.
    -- Dim roles support readability without competing for attention.
    -- ============================================================

    eve.parameter = blend(eve.lavender, eve.void, 0.58)

    eve.function_name = eve.cyan

    -- Methods stay related to functions, but use a deeper blue.
    eve.method_name = blend(eve.cyan, eve.electric_purple, 0.35)

    -- Gold expands EVE beyond the original terminal spectrum.
    -- Macros are intentionally bright because they represent a
    -- different compilation/preprocessing concept than functions.
    eve.gold = "#D6A94A"
    eve.gold_dim = blend(eve.gold, eve.void, 0.50)

    eve.macro = eve.gold

    eve.keyword = eve.pink
    eve.control = eve.rose
    eve.type = eve.bright_purple

    eve.member = eve.magenta
    eve.operator = eve.bright_pink
    -- Structural punctuation should remain visible without competing
    -- with identifiers, strings, functions, or control flow.
    --
    -- Start from the light-pink reference color, then heavily fade it
    -- toward EVE's void so brackets/parentheses act like scaffolding.
    eve.punctuation = blend("#FFD1DF", eve.void, 0.55)    eve.special = eve.bright_magenta

    eve.accent = eve.cyan

    return eve
end

return M
