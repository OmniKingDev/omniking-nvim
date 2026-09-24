return {
    {
        dir = vim.fn.expand("~/Projects/omniveil.nvim"),
        name = "omniveil",
        lazy = false,

        opts = {
            -- your OmniVeil settings live here
            glyph = {
                outline = {
                    enabled = false,
                }
            }
        },

        config = function(_, opts)
            require("omniveil").setup(opts)
        end,
    },
}
