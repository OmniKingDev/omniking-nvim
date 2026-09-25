-- EVE-MATRIX
--
-- Raw palette:
--   themes/ghostty/EVE-MATRIX
--
-- Semantic roles:
--   lua/omniking_lua/theme/eve_matrix/palette.lua
--
-- Highlight application:
--   lua/omniking_lua/theme/eve_matrix/highlights.lua

vim.cmd("highlight clear")

if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
end

vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "eve-matrix"

local eve =
    require("omniking_lua.theme.eve_matrix.palette").load()

require("omniking_lua.theme.eve_matrix.highlights").apply(eve)

local config =
    require("omniking_lua.theme.eve_shared.config").get()

require("omniking_lua.theme.eve_shared.surface").apply(eve, config)

