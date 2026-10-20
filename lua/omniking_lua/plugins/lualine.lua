return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = 'auto', -- Automatically grabs colors from the global colorscheme
      component_separators = '🖕',
      section_separators = { left = '', right = '' },
    },
    sections = {
      -- Passing a color string tells lualine to hook directly into that theme highlight block
      lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2, color = 'Visual' } },
      lualine_b = { { 'filename', color = 'StatusLine' }, 'branch' },
      lualine_c = { '%=' }, 
      lualine_x = {},
      lualine_y = { { 'filetype', color = 'StatusLine' }, 'progress' },
      lualine_z = { { 'location', separator = { right = '' }, left_padding = 2, color = 'Visual' } },
    },
  },
}

