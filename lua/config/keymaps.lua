-- REMAPS
--[[ these are no longer needed with the nightly verson of neovim
vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
vim.keymap.set('n', 'gra', vim.lsp.buf.code_action)
vim.keymap.set('n', 'grr', vim.lsp.buf.references)
--]]
-- - "grn" is mapped in Normal mode to |vim.lsp.buf.rename()|
-- - "gra" is mapped in Normal and Visual mode to |vim.lsp.buf.code_action()|
-- - "grr" is mapped in Normal mode to |vim.lsp.buf.references()|
-- - "gri" is mapped in Normal mode to |vim.lsp.buf.implementation()|
-- - "gO" is mapped in Normal mode to |vim.lsp.buf.document_symbol()|
-- -  CTRL-S is mapped in Insert mode to |vim.lsp.buf.signature_help()|

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
