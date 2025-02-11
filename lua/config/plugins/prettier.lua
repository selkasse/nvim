return {
  {
    'prettier/vim-prettier',
    config = function()
      -- Enable auto formatting
      vim.g.prettier_autoformat = 1
      -- Allow auto formatting for files without "@format" or "@prettier" tag
      vim.g.prettier_autoformat_require_pragma = 0

      -- Set up an autocommand to format on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.css", "*.scss", "*.html", "*.json", "*.cls"}, -- Add other file types as needed
        callback = function()
          vim.cmd("Prettier")
        end,
      })
    end
  }
}
