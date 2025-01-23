-- enable the ability to specify a file type when using telescope
local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local make_entry = require 'telescope.make_entry'
local conf = require 'telescope.config'.values

local M = {}

local live_multigrep = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  local finder = finders.new_async_job {
    -- prompt is what you type into the telescope finder
    command_generator = function(prompt)
      if not prompt or prompt == '' then
        return nil
      end

      --[[ split on two spaces because the file type
           argument will be provided after two spaces
           example prompt: 'button  .tsx'
      --]]
      local pieces = vim.split(prompt, '  ')
      local args = { 'rg' }

      -- remember, Lua indexes are 1-based
      if pieces[1] then
        table.insert(args, '-e') -- -e is the rg flag for providing a regex
        table.insert(args, pieces[1])
      end

      if pieces[2] then
        table.insert(args, '-g') -- -g is the rg flag for globbing
        --[[ glob example: function  **/plugins/**
             this will search for 'function' within the 'plugins' directory
        --]]
        table.insert(args, pieces[2])
      end

      ---@diagnostic disable-next-line: deprecated
      return vim.tbl_flatten {
        args,
        { '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case' },
      }
    end,

    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  }


  pickers.new(opts, {
    debounce = 100,
    prompt_title = 'Multi Grep',
    finder = finder,
    previewer = conf.grep_previewer(opts),
    sorter = require('telescope.sorters').empty(), -- don't sort since rg will have already sorted it
  }):find()
end

M.setup = function()
  vim.keymap.set('n', '<leader>fg', live_multigrep)
end

return M
