function ColorMyPencils(color)
    -- Default colorscheme
    color = color or "tokyonight"
    vim.cmd.colorscheme(color)
end

-- Installed Colorschemes
-- eve-prime
-- tokyonight
-- rose-pine

ColorMyPencils('eve-prime')
