local harpoon = require("harpoon")
harpoon:setup({})

-- basic telescope configuration
-- BUG: Cannot remove files from list
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers")
    .new({}, {
      prompt_title = "Harpoon",
      finder = require("telescope.finders").new_table({
        results = file_paths,
      }),
      previewer = conf.file_previewer({}),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_buffer_number, map)
        map(
          "i",
          "<leader>d", -- your mapping here
          function()
            local state = require("telescope.actions.state")
            local selected_entry = state.get_selected_entry()
            local current_picker = state.get_current_picker(prompt_buffer_number)

            harpoon:list():remove_at(selected_entry.index)
            current_picker:refresh(toggle_telescope(harpoon:list()))
          end
        )
        return true
      end
    })
    :find()
end

vim.keymap.set("n", "<leader>he", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon Menu" })

-- Telescope is not working fine, since I cannot edit the list
vim.keymap.set("n", "<leader>H", function()
 toggle_telescope(harpoon:list())
end, { desc = "Open harpoon window" })

vim.keymap.set("n", "<leader>hh", function()
  harpoon:list():add()
end, { desc = "Harpoon Add File" })

vim.keymap.set("n", "<leader>1", function()
  harpoon:list():select(1)
end, { desc = "Harpoon 1" })
vim.keymap.set("n", "<leader>2", function()
  harpoon:list():select(2)
end, { desc = "Harpoon 2" })
vim.keymap.set("n", "<leader>3", function()
  harpoon:list():select(3)
end, { desc = "Harpoon 3" })
vim.keymap.set("n", "<leader>4", function()
  harpoon:list():select(4)
end, { desc = "Harpoon 4" })

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>hp", function()
  harpoon:list():prev()
end, { desc = "Previous" })
vim.keymap.set("n", "<leader>hn", function()
  harpoon:list():next()
end, { desc = "Next" })
