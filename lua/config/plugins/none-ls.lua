return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local none_ls = require("null-ls")
    none_ls.setup({
      sources = {
        none_ls.builtins.formatting.alejandra,

        none_ls.builtins.formatting.prettier.with({
          filetypes = { "apex" },
          extra_args = { "--plugin=prettier-plugin-apex", "--write" },
        }),

        none_ls.builtins.formatting.prettierd.with({
          filetypes = { "html", "javascript" },
        }),

        none_ls.builtins.diagnostics.pmd.with({
          -- pmd v6
          filetypes = { "apex" },
          extra_args = { "--rulesets=$HOME/apex_ruleset.xml" }, -- Use the absolute path
        }),
      }
    })
  end,
}
