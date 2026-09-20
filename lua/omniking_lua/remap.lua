vim.g.mapleader = ' '

-- Vertical Resizing (Ctrl + Shift + < / >)
vim.keymap.set('n', '<C-S-,>', ':vertical resize -1<CR>', { noremap = true, desc = "Resize buffer right" })
vim.keymap.set('n', '<C-S-.>', ':vertical resize +1<CR>', { noremap = true, desc = "Resize buffer left" })

-- Horizontal Resizing (Ctrl + Shift + + / -)
vim.keymap.set('n', '<C-+>',  ':resize +1<CR>', { noremap = true, desc = "Increase window height" })
vim.keymap.set('n', '<C-_>',  ':resize -1<CR>', { noremap = true, desc = "Decrease window height" })

-- Show full diagnostic/error under cursor
vim.keymap.set('n', '<leader>ds', vim.diagnostic.open_float)

--Toggle clangd/LSP inlay hints
vim.keymap.set('n', '<leader>i', function()
    vim.lsp.inlay_hint.enable(
        not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }),
        { bufnr = 0 }
    )
end)

-- Directory and File Execution Shortcuts
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = "View current working directory." })
vim.keymap.set('n', '<leader><leader>x', '<cmd>source %<CR>', { desc = "Execute entire file." })

-- * Remap Primeagen Keymaps *
-- Used to move highlighted text up and down
vim.keymap.set('v', 'J', ":m \'>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m \'<-2<CR>gv=gv")

-- Set 'J' to not move cursor after appending to current line
vim.keymap.set('n', 'J', "mzJ`z")

-- Set page jumping to keep cursor in place
vim.keymap.set('n', '<C-d>', "<C-d>zz")
vim.keymap.set('n', '<C-u>', "<C-u>zz")

-- Keep cursor centered when going through highlighted searches
vim.keymap.set('n', 'n', "nzzzv")
vim.keymap.set('n', 'N', "Nzzzv")

-- Keep copied text in buffer after pasting over other text
vim.keymap.set('x', '<leader>p', "\"_dP")

-- Yank to clipboard
vim.keymap.set('n', '<leader>y', "\"+y")
vim.keymap.set('v', '<leader>y', "\"+y")
vim.keymap.set('n', '<leader>Y', "\"+Y")

-- Save deleted lines to clipboard
vim.keymap.set('n', '<leader>dd', "\"_d")
vim.keymap.set('v', '<leader>dd', "\"_d")

-- Ensure <C-c> is doing what <ESC> does
vim.keymap.set('i', '<C-c>', "<ESC>")

-- Not sure why but so be it, trust the process
vim.keymap.set('n', 'Q', "<nop>")

-- Switch project folder to another within HOME directory path
-- vim.keymap.set('n', '<C-f>', "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Navigate Fixes
vim.keymap.set('n', '<C-k>', "<cmd>cnext<CR>zz")
vim.keymap.set('n', '<C-j>', "<cmd>cprev<CR>zz")
vim.keymap.set('n', '<leader>k', "<cmd>lnext<CR>zz")
vim.keymap.set('n', '<leader>j', "<cmd>lprev<CR>zz")

-- Change word at where the cursor is positioned throughout entire file
vim.keymap.set('n', '<leader>s', ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
vim.keymap.set('n', '<leader>x', "<cmd> !chmod +x %<CR>", { silent = true })
