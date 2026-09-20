-- * For controlling cursor size *
-- vim.opt.guicursor = ""

-- * Line line numbers and relative number *
vim.opt.nu = true
vim.opt.relativenumber = true

-- * Control indent spacing *
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- * Added smart indenting *
vim.opt.smartindent = true

-- * Set window wrap *
vim.opt.wrap = false

-- * Control backups and undotree *
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

-- * Control highlight for search and incremental search *
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- * Gui color for terminal *
vim.opt.termguicolors = true

-- * Line distance from scrolling *
vim.opt.scrolloff = 8

-- * Fast update time *
vim.opt.updatetime = 50

-- * Add visual column to right of files *
-- vim.opt.colorcolumn = '80'
