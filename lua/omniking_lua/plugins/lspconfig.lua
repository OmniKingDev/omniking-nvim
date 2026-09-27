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
            -- Preserve your existing C/C++ configuration.
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

            vim.lsp.config('lua_ls', {
                settings = {
                    Lua = {
                        diagnostics = {
                            global = { 'vim' },
                        },
                    },
                },
            })

            -- Discover available language-server configurations.
            local enabled = {}

            for _, path in ipairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
                local name = vim.fn.fnamemodify(path, ":t:r")

                if name ~= 'gitlab_duo' and not enabled[name] then
                    enabled[name] = true

                    local config = vim.lsp.config[name]

                    if config
                        and type(config.cmd) == "table"
                        and type(config.cmd[1]) == "string"
                        and vim.fn.executable(config.cmd[1]) == 1
                    then
                        vim.lsp.enable(name)
                    end
                end
            end
        end,
    },
}
