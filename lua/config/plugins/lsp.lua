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
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = true,
        severity_sort = false,
      })

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local function toggle_inlay_hints()
        local bufnr = vim.api.nvim_get_current_buf()
        local current_value = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
        print('setting inlay hints to ' .. tostring((not current_value)))
        vim.lsp.inlay_hint.enable(not current_value, { bufnr = bufnr })
      end

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
            hint = { enable = true }
          },
        },
      }


      require 'lspconfig'.eslint.setup({
        cmd = { "eslint_d", "--stdin" },
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      })

      require 'lspconfig'.ts_ls.setup {
        filetypes = { "typescript", "typescript.tsx", "typescriptreact", "javascript", "javascriptreact", "javascript.tsx" },
      }


      local lspconfig = require('lspconfig')

      lspconfig.apex_ls.setup {
        cmd = {
          "java",
          "-jar",
          vim.fn.expand('$HOME/apex-jorje-lsp.jar'),
        },
        filetypes = { 'apex' },
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


      vim.keymap.set('n', '<leader>h', toggle_inlay_hints, { desc = "Toggle Inlay Hints" })
    end,
  }
}
