-------------------------
-- Various textobjects --
-------------------------
return {
  'chrisgrieser/nvim-various-textobjs',
  config = function()
    local map = require('utils').map
    local various_textobjs = require('various-textobjs')

    various_textobjs.setup({
      useDefaultKeymaps = true,
      disabledKeymaps = {
        'ig', -- Replaced with iG
        'ag', -- Replaced with aG
        'ii', -- Just use iI
        'ai', -- Just use aI
        'gG', -- Replaced with ie
        '|',  -- Replaced with i|
        'L',  -- Replaced with iu
        'r',  -- I only want this for normal mode
        '=',  -- Use Treesitter's @assignment instead
        'il', -- Replaced with iL
        'al', -- Replaced with aL
        'ic', -- Disabled (CSS class)
        'ac', -- Disabled (CSS class)
        'ix', -- Replaced with iX
        'ax', -- Replaced with iX
        'iD', -- Use vim-textobj-user's date instead
        'aD', -- Use vim-textobj-user's date instead
        'iS', -- Replaced with i-
        'aS', -- Replaced with a-
      },
    })

    local ox = { 'o', 'x' }
    map(ox, 'iG', function() various_textobjs.greedyOuterIndentation('inner') end, 'Greedy outer indentation')
    map(ox, 'aG', function() various_textobjs.greedyOuterIndentation('outer') end, 'Greedy outer indentation')
    map(ox, 'ie', various_textobjs.entireBuffer, 'Entire buffer')
    map(ox, 'iL', function() return various_textobjs.lineCharacterwise('inner') end, 'Line')
    map(ox, 'aL', function() return various_textobjs.lineCharacterwise('outer') end, 'Line')
    map(ox, 'i|', various_textobjs.column, 'Column')
    map(ox, 'iu', various_textobjs.url, 'URL')
    map(ox, 'id', various_textobjs.diagnostic, 'Diagnostic')
    map('o', 'r', various_textobjs.restOfParagraph, 'Rest of paragraph')
    map(ox, 'iX', function() return various_textobjs.htmlAttribute('inner') end, 'HTML attribute')
    map(ox, 'aX', function() return various_textobjs.htmlAttribute('outer') end, 'HTML attribute')
    map(ox, 'i-', function() return various_textobjs.subword('inner') end, 'HTML attribute')
    map(ox, 'a-', function() return various_textobjs.subword('outer') end, 'HTML attribute')

    local markdown_textobjs = function()
      local opts = { buffer = true }
      map(ox, 'ix', function() return various_textobjs.mdlink('inner') end, opts)
      map(ox, 'ax', function() return various_textobjs.mdlink('outer') end, opts)
      map(ox, 'ic', function() return various_textobjs.mdFencedCodeBlock('inner') end, opts)
      map(ox, 'ac', function() return various_textobjs.mdFencedCodeBlock('outer') end, opts)
    end

    local augroup = vim.api.nvim_create_augroup('VariousTextobjs', {})
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      group = augroup,
      callback = markdown_textobjs,
    })
    markdown_textobjs()

    -- Copied from README
    map('n', 'dsi', function()
      -- select inner indentation
      various_textobjs.indentation('inner', 'inner')

      -- Plugin only switches to visual mode when a textobj has been found
      local notOnIndentedLine = vim.fn.mode():find('V') == nil
      if notOnIndentedLine then
        return
      end

      -- Dedent indentation
      vim.cmd.normal { '<', bang = true }

      -- Delete surrounding lines
      local endBorderLn = vim.api.nvim_buf_get_mark(0, '>')[1] + 1
      local startBorderLn = vim.api.nvim_buf_get_mark(0, '<')[1] - 1
      vim.cmd(tostring(endBorderLn) .. ' delete') -- delete end first so line index is not shifted
      vim.cmd(tostring(startBorderLn) .. ' delete')
    end, { desc = 'Delete surrounding indentation' })
  end
}
