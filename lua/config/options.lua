-- press ctrl+x_ctrl+k to see dictionary suggestions
vim.opt.dictionary:append("~/dictionary.txt")


-- clipboard
vim.opt.clipboard = "unnamedplus"

-- INDENTATION

-- Set tabstop and shiftwidth to 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Set softtabstop to 4
vim.opt.softtabstop = 4

-- Convert tabs to spaces
vim.opt.expandtab = true

-- Ensure that indents are consistent with shiftwidth
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Disable highlighting on search
vim.opt.hlsearch = false;


-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "number"


vim.cmd('syntax on')
