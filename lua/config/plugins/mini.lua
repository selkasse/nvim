-- lua/config/plugins/mini.lua

return {
  {
    'echasnovski/mini.nvim',
    config = function()
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = true }
    end
  }
}

--[[
return {
  {
    'echasnovski/mini.nvim',
    config = function()
      local function get_current_time()
        local time = os.date('*t')
        return ("%02d:%02d"):format(time.hour, time.min)
      end

      local statusline    = require 'mini.statusline'
      local time_string   = get_current_time()
      local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
      local git           = statusline.section_git({ trunc_width = 40 })
      local diff          = statusline.section_diff({ trunc_width = 75 })
      local diagnostics   = statusline.section_diagnostics({ trunc_width = 75 })
      local lsp           = statusline.section_lsp({ trunc_width = 75 })
      local filename      = statusline.section_filename({ trunc_width = 140 })
      local fileinfo      = statusline.section_fileinfo({ trunc_width = 120 })
      local location      = statusline.section_location({ trunc_width = 75 })
      local search        = statusline.section_searchcount({ trunc_width = 75 })

      local function create_groups()
        if statusline then
          return statusline.combine_groups(
            {
              { hl = mode_hl,                 strings = { mode } },
              { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
              '%<', -- Mark general truncate point
              { hl = 'MiniStatuslineFilename', strings = { filename } },
              '%=', -- End left alignment
              { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
              { hl = mode_hl,                  strings = { search, location } },
              { hl = mode_hl,                  strings = { time_string } },
            })
        else
          print('unable to create statusline groups -- statusline is nil')
        end
      end

      local time_timer = vim.loop.new_timer()

      if time_timer then
        -- run every 10 seconds
        time_timer:start(0, 10000, vim.schedule_wrap(function()
          time_string = get_current_time()
          vim.opt.statusline = create_groups()
        end))
      else
        print('unable to update time -- time_timer is nil')
      end

      statusline.setup {
        content = {
          active = function()
            return create_groups();
          end,
          inactive = function()
            return 'test inactive'
          end
        },
        use_icons = true,
        set_vim_settings = true,
      }
    end
  }
}
--]]
