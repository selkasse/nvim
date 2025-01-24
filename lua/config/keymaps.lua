-- run whole file
vim.keymap.set('n', '<space><space>x', '<cmd>source %<CR>')

-- run current line
vim.keymap.set('n', '<space>x', ':.lua<CR>')

-- run selected text
vim.keymap.set('v', '<space>x', ':lua<CR>')

-- navigate quick fix list
vim.keymap.set('n', '<M-j>', '<cmd>cnext<CR>')
vim.keymap.set('n', '<M-k>', '<cmd>cprev<CR>')

-- remap ! to go to first non-blank character of line
vim.keymap.set('n', '!', '^')

-- remap Option + w for window navigation
vim.keymap.set('n', '<A-w>', '<C-w>')

-- close window
vim.keymap.set('n', '<space>c', '<cmd>close<CR>')

-- clear quickfix list
vim.keymap.set('n', '<space>qc', '<cmd>call setqflist([], "f")<CR>')


-- remap Option + c for copy
vim.keymap.set('n', '<A-c>', '"+y')
vim.keymap.set('v', '<A-c>', '"+y')

-- TERMINAL
JOB_ID = 0

vim.keymap.set('n', '<space>t', function()
  vim.cmd.new()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 15)

  _G['JOB_ID'] = vim.bo.channel
end)


-- send data to terminal without being in the terminal
vim.keymap.set('n', '<space>ex', function()
  if (_G['JOB_ID']) then
    vim.fn.chansend(_G['JOB_ID'], { 'ls -al\r\n' })
  else
    print('no job id to operate on')
  end
end)
