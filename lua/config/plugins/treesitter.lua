return {
  {

    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require 'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all" (the listed parsers MUST always be installed)
        ensure_installed = { "apex", "bash", "java", "soql", "sosl", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

        ignore_install = {},
        modules = {},

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        highlight = {
          enable = true,
          disable = function(_, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            -- local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            local ok, stats = pcall(_, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              print("disabling highlighting due to large file size")
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
      }
    end
  }
}
