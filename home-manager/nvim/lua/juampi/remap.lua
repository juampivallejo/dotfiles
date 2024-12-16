local fzf_lua = require("fzf-lua")

vim.keymap.set("n", "<C-p>", fzf_lua.files, { desc = "Fzf Files" })
vim.keymap.set("n", "<leader>r", fzf_lua.resume, { desc = "Resume Fzf" })

-- Keep buffer after pasting and replacing something
vim.keymap.set("n", "<leader>p", '"_dP', { desc = "Paste special" })
vim.keymap.set("v", "<leader>p", '"_dP', { desc = "Paste special" })

-- Yank to clipboard
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Yank +" }) -- Normal Mode
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank +" }) -- Visual Mode
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank EOL +" })

-- Keep cursor on middle of screen when scrolling
-- vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down custom" })
-- vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up custom" })

-- Naviate quickfix list
vim.keymap.set("n", "<C-A-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-A-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Set a keymap to change the filetype to htmldjango
vim.api.nvim_set_keymap("n", "<leader>ct", ":set filetype=htmldjango<CR>", { noremap = true, silent = true })
