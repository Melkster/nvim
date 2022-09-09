-------------
-- Notify --
-------------
return { 'rcarriga/nvim-notify',
  config = function()
    local plugin_setup = require('utils').plugin_setup
    local notify = require('notify')

    plugin_setup('notify',  {
      timeout = 2000,
    })

    vim.notify = notify

    -- LSP window/showMessage
    vim.lsp.handlers['window/showMessage'] = function(_, result, ctx)
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      local level = ({ 'ERROR', 'WARN', 'INFO', 'DEBUG' })[result.type]

      notify({ result.message }, level, {
        title = 'LSP | ' .. client.name,
        timeout = 10000,
        keep = function() return level == 'ERROR' or level == 'WARN' end,
      })
    end
  end
}
