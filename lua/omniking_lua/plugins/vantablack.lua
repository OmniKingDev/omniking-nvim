return {
    "bjarneo/vantablack.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("vantablack").setup()
        vim.cmd.colorscheme("vantablack")
    end,
}
