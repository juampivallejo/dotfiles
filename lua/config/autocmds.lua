-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
local autocmd_group = vim.api.nvim_create_augroup("Custom auto-commands", { clear = true })

-- Use C-n and C-p for quickfix list navigation
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function(event)
    local opts = { buffer = event.buf, silent = true }
    vim.keymap.set("n", "<C-n>", "<cmd>cn | wincmd p<CR>zz", opts)
    vim.keymap.set("n", "<C-p>", "<cmd>cN | wincmd p<CR>zz", opts)
  end,
})

-- Set commentstring for SQL files to make sure Dadbod plugin works correctly
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql", "dbout" },
  callback = function()
    vim.bo.commentstring = "-- %s"
  end,
})
