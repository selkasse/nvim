return {
  {
    'echasnovski/mini.nvim',
    config = function()
      local statusline = require 'mini.statusline'

      -- Function to get the current time formatted as HH:MM AM/PM
      local function get_current_time()
        local time = os.date('*t')
        return ("%02d:%02d %s"):format(time.hour % 12 == 0 and 12 or time.hour % 12, time.min,
          time.hour >= 12 and "PM" or "AM")
      end

      -- Function to draw the status line
      local function draw_status_line()
        local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
        local git = statusline.section_git({ trunc_width = 40 })
        local diff = statusline.section_diff({ trunc_width = 75 })
        local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
        local lsp = statusline.section_lsp({ trunc_width = 75 })
        local filename = statusline.section_filename({ trunc_width = 140 })
        local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
        local location = statusline.section_location({ trunc_width = 75 })
        local search = statusline.section_searchcount({ trunc_width = 75 })

        return statusline.combine_groups({
          { hl = mode_hl,                 strings = { mode } },
          { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
          '%<', -- Mark general truncate point
          { hl = 'MiniStatuslineFilename', strings = { filename } },
          '%=', -- End left alignment
          { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
          { hl = mode_hl,                  strings = { search, location } },
          { hl = mode_hl,                  strings = { get_current_time() } }, -- Display the current time
        })
      end


      -- Setup the statusline with dynamic content
      statusline.setup {
        content = {
          active = draw_status_line, -- Call the function to get the current groups
        },
        use_icons = true,
        set_vim_settings = true -- make the status line show at all times
      }

      -- Timer to update the time every minute (60000 milliseconds)
      local time_timer = vim.loop.new_timer()
      if time_timer then
        time_timer:start(0, 6000, vim.schedule_wrap(function()
          draw_status_line() -- Update the status line
        end))
      else
        print('Unable to update time -- time_timer is nil')
      end
    end
  }
}
