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
vim.api.nvim_set_keymap('n', '!', '^', { noremap = true, silent = true })

-- remap Option + w for window navigation
vim.api.nvim_set_keymap('n', '<A-w>', '<C-w>', { noremap = true, silent = true })

-- close window
vim.keymap.set('n', '<space>c', '<cmd>close<CR>')

-- clear quickfix list
vim.keymap.set('n', '<space>qc', '<cmd>call setqflist([], "f")<CR>')


-- remap Option + c for copy
vim.api.nvim_set_keymap('n', '<A-c>', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-c>', '"+y', { noremap = true, silent = true })

-- terminal
--vim.keymap.set
