function ColorMyPencils(color)
    -- Default colorscheme
    color = color or 'eve-prime'
    vim.cmd.colorscheme(color)
end

-- Installed Colorschemes
-- eve-prime
-- tokyonight
-- rose-pine
-- vantablack
-- miasma

ColorMyPencils()
