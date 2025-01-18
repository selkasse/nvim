
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Disable automatic commenting and automatic insertion of comment leaders
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove("c")  -- Disable auto-commenting
        vim.opt_local.formatoptions:remove("r")  -- Disable auto-inserting comment leader
        vim.opt_local.formatoptions:remove("o")  -- Disable auto-inserting comment leader on 'o' and 'O'
    end,
})
