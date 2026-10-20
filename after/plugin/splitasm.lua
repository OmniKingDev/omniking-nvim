-- Fix the colorscheme block: Give SplitAsm actual visual colors by linking it to Visual selection
vim.api.nvim_set_hl(0, 'SplitAsm', { link = 'Search' })

-- Direct structural mapping without layout hooks or loop injections
vim.keymap.set('n', '<leader>aa', vim.cmd.SplitAsm, { desc = 'Toggle compiler explorer on current file.' })
