-- EVE-PRIME
--
-- This file is intentionally small.
--
-- Palette ownership:
--   themes/ghostty/EVE-PRIME
--
-- Neovim semantic color mapping:
--   lua/omniking_lua/theme/eve_prime/palette.lua
--
-- Neovim highlight ownership:
--   lua/omniking_lua/theme/eve_prime/highlights.lua

vim.cmd("highlight clear")

if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
end

vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "eve-prime"

local eve =
    require("omniking_lua.theme.eve_prime.palette").load()

require("omniking_lua.theme.eve_prime.highlights").apply(eve)
