return {
  'OXY2DEV/markview.nvim',
  ft = 'markdown',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons'
  },
  config = function()
    local markview = require('markview')
    local no_padding = { add_padding = false }

    local config = {
      code_blocks = {
        sign = false,
      },
      tables = {
        use_virt_lines = true,
      },
      list_items = {
        marker_minus = {
          add_padding = false,
          text = '󰧞',
        },
        marker_plus = no_padding,
        marker_star = no_padding,
        marker_dot = no_padding,
      }
    }

    markview.configuration = vim.tbl_deep_extend('force', markview.configuration, config)
  end
}
