-- EVE-DARKMATRIX
--
-- Raw palette:
--   themes/ghostty/EVE-DARKMATRIX
--
-- Semantic roles:
--   lua/omniking_lua/theme/eve_darkmatrix/palette.lua
--
-- Highlight application:
--   lua/omniking_lua/theme/eve_darkmatrix/highlights.lua

vim.cmd("highlight clear")

if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
end

vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "eve-darkmatrix"

local eve =
    require("omniking_lua.theme.eve_darkmatrix.palette").load()

require("omniking_lua.theme.eve_darkmatrix.highlights").apply(eve)
