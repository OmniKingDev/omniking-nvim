return {
  'j-hui/fidget.nvim',
  opts = {
    -- Your custom done icon
    progress = {
      display = {
        done_icon = '👍(•̀＿•́)👍',
      },
    },
    -- Integrating the custom language switch tracker
    notification = {
      window = {
        winblend = 0, -- Fully opaque or set to 15 for transparency
      },
    },
  },
  config = function(_, opts)
    -- Initialize fidget with your options
    require('fidget').setup(opts)

    -- Track the last seen filetype
    local last_ft = ""

    -- Create an autocommand to catch buffer switches
    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("FidgetLanguageTracker", { clear = true }),
      callback = function()
        local current_ft = vim.bo.filetype

        -- Skip empty, special buffers, or matching the last filetype
        if current_ft == "" or current_ft == last_ft then
          return
        end

        -- Update the last seen tracker
        last_ft = current_ft

        -- Trigger a custom Fidget loading notification for the new language
        local handle = require("fidget.progress").handle.create({
          title = "Initializing Language",
          message = string.format("Loading support for [%s]...", current_ft),
          lsp_client = { name = "Tree-sitter/LSP" },
        })

        -- Simulate the load UI finish after a brief moment (e.g., 800ms)
        -- This ensures you visually see it spin up and finish with your icon
        vim.defer_fn(function()
          handle:finish()
        end, 800)
      end,
    })
  end,
}
