require("options")
require("plugins")

-- Post-install plugin configuration

-- Whitespace highlighting groups
vim.cmd[[highlight ExtraWhitespace ctermbg=lightgreen guibg=lightgreen]]

-- Fix for lua_ls to recognize `vim` as a global
require("lspconfig").lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = {"vim"},
      },
    },
  },
})

-- go.nvim configuration
-- Run gofmt + goimports on save
local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimports()
  end,
  group = format_sync_grp,
})

-- Configuring tab stops
-- vim.api.nvim_create_autocmd("FileType"
-- autocmd FileType scala,perl,css,javascript,java,xs,xml set tabstop=8 shiftwidth=4 smarttab expandtab softtabstop=4 autoindent
-- autocmd FileType python,ruby,rakefile,c,cpp,html,eruby,vim  set tabstop=8 shiftwidth=4 smarttab expandtab softtabstop=4 autoindent
-- autocmd FileType avro-idl,json,rest                         set tabstop=8 shiftwidth=4 smarttab expandtab softtabstop=4 autoindent
-- autocmd FileType make set noexpandtab ts=8 sw=8
-- autocmd BufEnter */debian/rules set noexpandtab ts=8 sw=8
