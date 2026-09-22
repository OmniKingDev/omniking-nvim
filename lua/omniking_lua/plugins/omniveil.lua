return {
    {
        dir = vim.fn.expand("~/Projects/omniveil.nvim"),
        name = "omniveil",
        lazy = false,

        config = function()
            require("omniveil").setup()
        end,
    },
}
