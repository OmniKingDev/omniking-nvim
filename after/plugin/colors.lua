function ColorMyPencils(color)
    -- Default colorscheme
    color = color or 'rose-pine'
    vim.cmd.colorscheme(color)
end

-- Installed Colorschemes
-- eve-prime
-- tokyonight
-- rose-pine
-- vantablack
-- miasma

ColorMyPencils('miasma')
