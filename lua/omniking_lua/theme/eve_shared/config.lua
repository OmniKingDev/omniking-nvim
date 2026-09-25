local M = {}

local options = {
    use_terminal_background = true,
}

function M.setup(opts)
    options = vim.tbl_deep_extend("force", options, opts or {})
end

function M.get()
    return options
end

return M
