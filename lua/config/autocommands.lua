-- Use an augroup to avoid duplicating the autocmd if you reload your config
vim.api.nvim_create_augroup('AutoHelp', { clear = true})

--vim.api.nvim_create_autocmd('VimEnter', {
    --group = 'AutoHelp',
    --pattern = '*',
    --command = 'help ins-completion'
--})

--vim.api.nvim_create_autocmd('VimEnter', {
    --group = 'AutoHelp',
    --pattern = '*',
    --command = 'vsplit'
--})

--vim.api.nvim_create_autocmd('VimEnter', {
    --group = 'AutoHelp',
    --pattern = '*',
    --command = 'help lsp'
--})

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup(
        'kickstart-highlight-yank', { clear = true}
    ),
    callback = function()
        vim.highlight.on_yank()
    end,
})
