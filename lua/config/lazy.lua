-- Bootstrap lazy.vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- LEARN SOMETHING, DAMN IT

-- Use an augroup to avoid duplicating the autocmd if you reload your config
vim.api.nvim_create_augroup('AutoHelp', { clear = true})

vim.api.nvim_create_autocmd('VimEnter', {
    group = 'AutoHelp',
    pattern = '*',
    command = 'help ins-completion'
})

vim.api.nvim_create_autocmd('VimEnter', {
    group = 'AutoHelp',
    pattern = '*',
    command = 'vsplit'
})

vim.api.nvim_create_autocmd('VimEnter', {
    group = 'AutoHelp',
    pattern = '*',
    command = 'help lsp'
})

-- place cursor over x in "print(x)"
-- use Control + ] to "jump to tag" (local x = 5)
-- use Option + T to "jump back" to x in print (x)
-- -- this was remapped from its original mapping of Control + T (conflicted with new terminal tab)

local x = 5
-- hover over a function like print and press K to get a hover
print(x)





-- clipboard
vim.opt.clipboard="unnamedplus"

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

-- REMAPS
vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
vim.keymap.set('n', 'gra', vim.lsp.buf.code_action)
vim.keymap.set('n', 'grr', vim.lsp.buf.references)

-- remap Option + w for window navigation
vim.api.nvim_set_keymap('n', '<A-w>', '<C-w>', { noremap = true, silent = true })

-- remap Option + c for copy
vim.api.nvim_set_keymap('n', '<A-c>', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-c>', '"+y', { noremap = true, silent = true })

-- remap cControl + spacebar for omnicomplete
vim.api.nvim_set_keymap('i', '<C-Space>', '<C-x><C-o>', { noremap = true, silent = true })

-- remap Option + t for "jump back to tag"
vim.api.nvim_set_keymap('n', '<A-t>', '<C-t>', { noremap = true, silent = true })


-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import your plugins
        { "folke/tokyonight.nvim", config = function() vim.cmd.colorscheme "tokyonight" end },

        { import = "config.plugins" }
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = {"tokyonight"} },
})
