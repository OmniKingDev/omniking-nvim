local harpoon = require("harpoon")

harpoon:setup()

-- Mark Current File
vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end)

-- Open Harpoon Menu
vim.keymap.set("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

-- Navigate Marked Files
vim.keymap.set("n", "<C-j>", function()
	harpoon:list():select(1)
end)

vim.keymap.set("n", "<C-k>", function()
	harpoon:list():select(2)
end)

vim.keymap.set("n", "<C-l>", function()
	harpoon:list():select(3)
end)

vim.keymap.set("n", "<C-;>", function()
	harpoon:list():select(4)
end)
