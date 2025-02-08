return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'saghen/blink.cmp',
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      require("lspconfig").lua_ls.setup {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT', -- Use LuaJIT for Neovim
              path = vim.split(package.path, ';'),
            },
            diagnostics = {
              globals = { 'vim' }, -- Declare 'vim' as a global
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true), -- Include Neovim runtime files
            },
          },
        },
      }

      require 'lspconfig'.eslint.setup({
        on_attach = function(_, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
      })

      require 'lspconfig'.ts_ls.setup {
        on_attach = function(client, bufnr)
          if client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
              end,
            })
          end
        end,
        filetypes = { "typescript", "typescriptreact", "typescript.tsx" }, -- Ensure these file types are included
      }


      -- require 'lspconfig'.apex_ls.setup {
      --   apex_jar_path = '/Users/sharif/.config/nvim/apex-jorje-lsp.jar',
      --   apex_enable_semantic_errors = true,        -- Whether to allow Apex Language Server to surface semantic errors
      --   apex_enable_completion_statistics = false, -- Whether to allow Apex Language Server to collect telemetry on code completion usage
      -- }

      -- vim.cmd [[
      --   augroup ApexFileType
      --   autocmd!
      --   autocmd BufNewFile,BufRead *.cls set filetype=apexcode
      --   augroup END
      -- ]]


      local lspconfig = require('lspconfig')

      lspconfig.apex_ls.setup {
        cmd = {
          vim.env.JAVA_HOME and (vim.env.JAVA_HOME .. '/bin/java') or 'java',
          '-cp',
          '/Users/sharif/.config/nvim/apex-jorje-lsp.jar',
          '-Ddebug.internal.errors=true',
          '-Ddebug.semantic.errors=true',
          '-Ddebug.completion.statistics=false',
          '-Dlwc.typegeneration.disabled=true',
          'apex.jorje.lsp.ApexLanguageServerLauncher',
        },
        filetypes = { 'apexcode' },
        root_dir = lspconfig.util.root_pattern('sfdx-project.json', '.git'),
        settings = {
          apex = {
            apex_enable_semantic_errors = true,
            apex_enable_completion_statistics = false,
          },
        },
      }

      -- listen for 'LspAttach' events
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          -- if the client supports formatting,
          --       create a local event listner that listens for 'BufWritePre'
          --       (right before a buffer is written)
          if client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
        end,
      })
    end,
  }
}
