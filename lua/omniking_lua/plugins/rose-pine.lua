return {
	"rose-pine/neovim", -- chosen colorscheme
	lazy = false, -- load during startup for main colorscheme
	priority = 1000, -- load before all other plugins
	name = "rose-pine", -- set name for colorscheme
	config = function()
		-- load colorscheme here
		vim.cmd([[colorscheme rose-pine]])
	end
}
