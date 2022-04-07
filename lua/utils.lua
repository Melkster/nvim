local M = {}

M.termcodes = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

M.map = function(modes, lhs, rhs, opts)
  if type(opts) == 'string' then
    opts = { desc = opts }
  end
  vim.keymap.set(modes, lhs, rhs, opts)
end

M.feedkeys = function(keys, mode)
  if mode == nil then mode = 'i' end
  return vim.api.nvim_feedkeys(M.termcodes(keys), mode, true)
end

M.error = function(message)
  vim.api.nvim_echo({{ message, 'Error' }}, false, {})
end

M.autocmd = function(event, opts)
  if opts.group then
    vim.api.nvim_create_augroup(opts.group, {})
  else
    opts.group = 'DefaultAugroup'
    vim.api.nvim_create_augroup('DefaultAugroup', {})
  end

  vim.api.nvim_create_autocmd(event, opts)
end

M.visible_buffers = function()
  local bufs = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    bufs[vim.api.nvim_win_get_buf(win)] = true
  end
  return vim.tbl_keys(bufs)
end

return M
