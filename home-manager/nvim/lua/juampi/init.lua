require("juampi.remap")
require("juampi.harpoon")
require("juampi.set")


-- NOTE: Used for LSP testing, this attaches my custom LSP to NeoVim
-- local client = vim.lsp.start_client {
--   name = "basiclsp",
--   cmd = {"/home/juampi/projects/basic-lsp/main"},
--   on_attach = require("lazyvim.util").lsp.on_attach,
--  }
-- if not client then
--   vim.notify "Hey, you did not setup the basiclsp client well"
--   return
-- end
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern="markdown",
--   callback = function()
--     vim.lsp.buf_attach_client(0, client)
--   end,
-- })
