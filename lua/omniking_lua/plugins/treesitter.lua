return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        opts = function(_, opts)
            -- Ensure both c and cpp parsers are installed
            if type(opts.ensure_installed) == "table" then
                vim.list_extend(opts.ensure_installed, { "c", "cpp" })
            end
        end,
    },
}
