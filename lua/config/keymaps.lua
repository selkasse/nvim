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

-- open Oil.nvim
vim.keymap.set('n', '<space>o', '<cmd>Oil<CR>')


-- TERMINAL
-- go to normal mode in terminal
vim.keymap.set('t', '<esc>', '<C-\\><C-N>')

JOB_ID = 0
TERM_WINDOW = 0

local open_terminal = function()
  vim.cmd.new()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 15)

  _G['JOB_ID'] = vim.bo.channel
end

local function is_terminal_open()
  local windows = vim.api.nvim_tabpage_list_wins(0) -- Get all windows in the current tab
  -- use _ to denote that we aren't using the 'index' value
  for _, win in ipairs(windows) do
    local bufnr = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_buf_get_option(bufnr, 'buftype') == 'terminal' then
      _G['TERM_WINDOW'] = win
      return true -- Found an open terminal window
    end
  end
  return false -- No terminal window is open
end

vim.keymap.set('n', '<space>t', open_terminal)

-- send data to the terminal without being in the terminal
vim.keymap.set('n', '<space>ex', function()
  if is_terminal_open() then
    -- If a terminal is open, get the terminal buffer
    local bufnr = vim.api.nvim_win_get_buf(_G['TERM_WINDOW'])
    _G['JOB_ID'] = vim.api.nvim_buf_get_option(bufnr, 'channel') -- Get the channel of the open terminal buffer

    -- Send the command to the existing terminal
    vim.fn.chansend(_G['JOB_ID'], 'ls -al\r\n')
  else
    -- If no terminal is open, open a new one and send the command
    open_terminal()
    _G['JOB_ID'] = vim.bo.channel -- Update JOB_ID after opening the terminal
    vim.fn.chansend(_G['JOB_ID'], 'ls -al\r\n')
  end
end)
