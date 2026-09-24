return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,

        ---@type snacks.Config
        opts = {
            bigfile = { enabled = true },
            input = { enabled = true },
            notifier = {
                enabled = true,
                timeout = 3000,
            },
            picker = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            words = { enabled = false },
        },

        keys = {
            -- Files / searching
            { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
            { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
            { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent Files" },
            { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },

            -- Buffers
            { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },

            -- Code / LSP
            { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
            { "gr", function() Snacks.picker.lsp_references() end, desc = "References" },

            -- Useful discovery
            { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
            { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
            { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },

            -- Theme work :)
            { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },

            -- Notifications
            { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification History" },

            -- Utilities
            { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
            { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
        },
    },
}
