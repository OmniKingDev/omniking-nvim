-- EVE
--
-- Canonical EVE colorscheme entrypoint.
--
-- Raw palette:
--   themes/ghostty/EVE
--
-- Semantic palette:
--   lua/omniking_lua/theme/eve/palette.lua
--
-- Highlight mapping:
--   lua/omniking_lua/theme/eve/highlights.lua

vim.cmd("highlight clear")

if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
end

vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "eve"

local eve =
    require("omniking_lua.theme.eve.palette").load()

require("omniking_lua.theme.eve.highlights").apply(eve)

local config =
    require("omniking_lua.theme.eve_shared.config").get()

require("omniking_lua.theme.eve_shared.surface").apply(eve, config)

