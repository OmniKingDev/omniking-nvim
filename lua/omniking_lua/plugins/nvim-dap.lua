return {
  {
    url = "https://codeberg.org/mfussenegger/nvim-dap",
    name = "nvim-dap",

    -- Lazy invokes this after nvim-dap has loaded its runtime module.
    -- The wildcard module registers the GDB adapter and fallback config.
    config = function()
      require("omniking_lua.config.nvim-dap").setup()
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "nvim-neotest/nvim-nio",
    },
    main = "dapui",
    opts = {
      layouts = {
        {
          position = "left",
          size = 46,
          elements = {
            { id = "scopes", size = 0.35 },
            { id = "stacks", size = 0.20 },
            { id = "breakpoints", size = 0.15 },
            { id = "watches", size = 0.30 },
          },
        },
        {
          position = "bottom",
          size = 12,
          elements = {
            { id = "repl", size = 0.60 },
            { id = "console", size = 0.40 },
          },
        },
      },
    },
  },
}

