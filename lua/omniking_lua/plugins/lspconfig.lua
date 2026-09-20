return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "folke/neoconf.nvim",
                cmd = "Neoconf",
                opts = {},
            },
        },

        config = function()
            vim.lsp.config("clangd", {
                root_markers = {
                    "compile_commands.json",
                    "compile_flags.txt",
                    "configure.ac",
                    "Makefile",
                    "configure.in",
                    "config.h.in",
                    "meson.build",
                    "meson_options.txt",
                    "build.ninja",
                    ".git",
                },

                capabilities = {
                    offsetEncoding = { "utf-16" },
                },

                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                    "--function-arg-placeholders",
                    "--fallback-style=llvm",
                },

                init_options = {
                    usePlaceholders = true,
                    completeUnimported = true,
                    clangdFileStatus = true,
                },
            })

            vim.lsp.enable("clangd")
        end,
    },
}
