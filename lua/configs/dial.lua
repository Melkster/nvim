---------------
-- Dial.nvim --
---------------
return { 'monaqa/dial.nvim',
  keys = {
    { '<C-a>',  '<Plug>(dial-increment)', mode = { 'n',  'x' } },
    { '<C-x>',  '<Plug>(dial-decrement)', mode = { 'n',  'x' } },
    { 'g<C-a>', '<Plug>(dial-increment)', mode = 'x' },
    { 'g<C-x>', '<Plug>(dial-decrement)', mode = 'x' },
  },
  config = function()
    local augend = require('dial.augend')

    local function add_constant(elements)
      return augend.constant.new {
        elements = elements,
        cyclic = true,
        word = true
      }
    end

    require('dial.config').augends:register_group {
      default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.integer.alias.binary,
        augend.date.alias['%Y/%m/%d'],
        augend.date.alias['%H:%M'],
        augend.constant.alias.ja_weekday,
        augend.constant.alias.ja_weekday_full,
        augend.constant.alias.bool,
        augend.misc.alias.markdown_header,
        add_constant({'and', 'or'}),
        add_constant({'&&', '||'}),
        add_constant({'TRUE', 'FALSE'}),
        add_constant({'private', 'public'}),
        add_constant({
          'one',   'two',   'three', 'four', 'five',   'six',
          'seven', 'eight', 'nine',  'ten',  'eleven', 'twelve'
        }),
        add_constant({
          'en', 'ett', 'två', 'tre', 'fyra', 'fem', 'sex',
          'sju', 'åtta', 'nio', 'tio', 'elva', 'tolv'
        }),
      }
    }
  end
}
