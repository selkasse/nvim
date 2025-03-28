if vim.g.vscode then
  -- VSCode extension
  require("config.shared")
else
  -- regular nvim
  require("config.lazy") -- loads ~/.config/nvim/lua/config/lazy.lua
  require("config.shared")
  require("config.autocommands")
  require("config.options")
  require("config.keymaps")
end
