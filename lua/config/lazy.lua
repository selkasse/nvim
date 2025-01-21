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


-- vim.fn.stdpath("data") is /Users/sharif/.local/share/nvim
-- lazypath is /Users/sharif/.local/share/nvim/lazy/lazy.nvim
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.cmd [[hi @function.builtin guifg=yellow]]


-- Setup lazy.nvim
--[[ ~/.local/share/nvim/lazy/lazy.nvim/lua/lazy/init.lua
has a `setup` function, which is what is called below --]]
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

