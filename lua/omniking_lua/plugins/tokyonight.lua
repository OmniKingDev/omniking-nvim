return {
	"folke/tokyonight.nvim", -- chosen colorscheme
	lazy = false, -- load during startup for main colorscheme
	priority = 1000, -- load before all other plugins
	name = "tokyonight", -- set name for colorscheme
	config = function()
		-- load colorscheme here
		vim.cmd([[colorscheme tokyonight]])
	end
}
