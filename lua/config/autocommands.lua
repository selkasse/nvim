vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup(
    'kickstart-highlight-yank', { clear = true }
  ),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  desc = 'Correctly set the filetype for Apex files',
  group = vim.api.nvim_create_augroup('ApexFileType', { clear = true }),
  pattern = '*.cls',
  callback = function()
    vim.cmd('set filetype=apex')
  end
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Enable block commenting for Apex files',
  group = vim.api.nvim_create_augroup('ApexComment', { clear = true }),
  pattern = 'apex',
  callback = function()
    vim.opt_local.commentstring = '// %s'
  end
})

-- vim.api.nvim_create_autocmd('TermOpen', {
--   desc = 'set global variable JOB_ID when terminal is opened',
--   group = vim.api.nvim_create_augroup(
--     'on-terminal-launch', { clear = true }
--   ),
--   callback = function()
--     _G['JOB_ID'] = vim.bo.channel
--   end,
-- })
