-- Require Tree-sitter Plugin Then Install Tree-sitter For Selected Languages Below
local treesitter = require("nvim-treesitter")

-- Tree-sitter Parser Tiers
-- Every Parser That Isn't Marked Broken/Unsupported
treesitter.install({
    "stable",
    "unstable",
    "unmaintained",
})

-- Used To Identify FileType Within Current Buffer Or New Buffer Window
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	-- Call Tree-sitter To Start Call To Function
	callback = function()
		pcall(vim.treesitter.start)
	end,
})
