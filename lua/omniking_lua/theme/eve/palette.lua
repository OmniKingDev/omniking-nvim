local M = {}

-- Canonical EVE palette.
--
-- Ghostty owns the raw color spectrum:
--   themes/ghostty/EVE
--
-- This file reads that spectrum and gives the colors semantic
-- meaning for Neovim without duplicating the raw hex values.

local default_theme =
    vim.fn.stdpath("config") .. "/themes/ghostty/EVE"

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
        error("EVE palette not found: " .. path)
    end

    local raw = {
        palette = {},
    }

    for _, original_line in ipairs(vim.fn.readfile(path)) do
        local line = trim(original_line)

        -- Ghostty comments begin with '#'.
        -- Hex colors also begin with '#', so only skip the line
        -- when the first non-whitespace character is '#'.
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

    assert(raw.background, "EVE is missing background")
    assert(raw.foreground, "EVE is missing foreground")

    for index = 0, 15 do
        assert(
            raw.palette[index],
            "EVE is missing palette index " .. index
        )
    end

    return raw
end

function M.load(path)
    local raw = parse_theme(path or default_theme)
    local ansi = raw.palette

    -- ========================================================
    -- RAW EVE IDENTITY
    --
    -- These names describe appearance, not ANSI semantics.
    -- ========================================================

    local eve = {
        raw = raw,

        background = raw.background,
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
        gold = ansi[15],

        selection_bg = raw.selection_background,
        selection_fg = raw.selection_foreground,
    }

    -- ========================================================
    -- DEFAULT EVE SEMANTIC LANGUAGE
    --
    -- Default EVE intentionally stays simple.
    -- Multiple syntax concepts are allowed to share colors.
    -- We only introduce distinctions that improve readability.
    -- ========================================================

    eve.text = eve.salmon
    eve.text_bright = eve.lavender
    eve.muted = blend(eve.salmon, eve.background, 0.62)

    -- Main syntax families.
    eve.keyword = eve.pink
    eve.control = eve.rose
    eve.structure = eve.bright_violet
    eve.string = eve.bright_pink
    eve.number = eve.violet
    eve.operator = eve.bright_pink
    eve.special = eve.bright_magenta

    -- Comments are intentionally faint cyan.
    --
    -- The raw cyan is extremely bright, so fading it toward the
    -- EVE surface keeps comments recessed while preserving the
    -- cyan identity even on a transparent presentation.
    eve.comment = blend(eve.cyan, eve.background, 0.58)

    -- NOTE: is deliberate emphasis.
    eve.note = eve.gold

    -- The text following NOTE: remains cyan but comes forward
    -- compared with an ordinary comment.
    eve.note_text = blend(eve.cyan, eve.background, 0.22)

    -- General accent for UI elements that genuinely need one.
    eve.accent = eve.cyan

    return eve
end

return M
