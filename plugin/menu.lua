vim.cmd [[
aunmenu PopUp

anoremenu PopUp.Go\ to\ definition      <Cmd>lua vim.lsp.buf.definition()<CR>
anoremenu PopUp.-1-                     <Nop>
anoremenu PopUp.Inspect                 <Cmd>Inspect<CR>
amenu     PopUp.Open\ in\ web\ browser  gx
anoremenu PopUp.References              <cmd>Telescope lsp_references<CR>
"anoremenu PopUp.Open\ Inventory               <cmd>echo "open inventory" <CR>

]]

local group = vim.api.nvim_create_augroup('nvim_popupmenu', { clear = true })


vim.api.nvim_create_autocmd('MenuPopup', {
  pattern = "*",
  group = group,
  desc = "Custom PopUp Setup",
  callback = function()
    -- Only show certain menu items if there is an LSP attached
    vim.cmd [[
      amenu disable PopUp.Go\ to\ definition
      amenu disable PopUp.References
      "amenu disable PopUp.Inspect
    ]]

    -- Comment this section to remove the items from the menu
    if vim.lsp.get_clients({ bufnr = 0 })[1] then
      vim.cmd [[
        amenu enable PopUp.Go\ to\ definition
        amenu enable PopUp.References
      ]]
    end
    -- Comment this section to remove the items from the menu


    local urls = require('vim.ui')._get_urls()
    if vim.startswith(urls[1], 'http') then
      vim.cmd [[amenu enable PopUp.Open\ in\ web\ browser]]
    end
  end
})
