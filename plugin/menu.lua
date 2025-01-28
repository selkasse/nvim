vim.cmd [[
aunmenu PopUp

anoremenu PopUp.Go\ to\ definition      <Cmd>lua vim.lsp.buf.definition()<CR>
anoremenu PopUp.-1-                     <Nop>
anoremenu PopUp.Inspect                 <Cmd>Inspect<CR>
amenu     PopUp.Open\ in\ web\ browser  gx
anoremenu PopUp.References              <cmd>Telescope lsp_references<CR>

]]

local group = vim.api.nvim_create_augroup('nvim_popupmenu', { clear = true })


vim.api.nvim_create_autocmd('MenuPopup', {
  pattern = "*",
  group = group,
  desc = "Custom PopUp Setup",
  callback = function()
    -- Only show Go to Definition if there is an LSP attached
    vim.cmd [[
      amenu disable PopUp.Go\ to\ definition
      amenu disable PopUp.References
    ]]

    if vim.lsp.get_clients({ bufnr = 0 })[1] then
      vim.cmd [[
        amenu enable PopUp.Go\ to\ definition
        amenu enable PopUp.References
      ]]
    end

    local urls = require('vim.ui')._get_urls()
    if vim.startswith(urls[1], 'http') then
      vim.cmd [[amenu enable PopUp.Open\ in\ web\ browser]]
    end
  end
})
