return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
      }
    },
    config = function()
      require('telescope').setup {
        pickers = {
          find_files = {
            theme = "ivy"
          },
          help_tags = {
            theme = "ivy"
          },
        },
        extensions = {
          fzf = {}
        }
      }

      require('telescope').load_extension('fzf')

      -- search help tags
      vim.keymap.set('n', '<space>fh', require('telescope.builtin').help_tags)

      local dir = vim.uv.cwd()

      -- search the current directory
      vim.keymap.set('n', '<space>fd', function()
        require('telescope.builtin').find_files {
          --prompt_title = 'Find in Current Directory (fd)'
          prompt_title = 'Find in ' .. dir,
          find_command = { "rg", "--files", "--no-ignore", "--hidden" },
          file_ignore_patterns = { "node_modules" },
        }
      end)


      -- search ~/.config/neovim/ directory regardless of the current folder
      -- this is useful if you want to edit your nvim config while working on a project
      vim.keymap.set('n', '<space>fc', function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.stdpath("config"),
          prompt_title = 'Find in Config (fc)'
        }
      end)

      -- search within plugins
      vim.keymap.set('n', '<space>fp', function()
        require('telescope.builtin').find_files {
          cwd = tostring(vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy'))
        }
      end)

      require 'config.telescope.multigrep'.setup()
    end
  }
}
